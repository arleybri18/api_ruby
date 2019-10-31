# -*- coding: utf-8 -*-
##
# Function that setup the watir browser

def setup_browser(url)
  browser = Watir::Browser.new :firefox, headless: true
  browser.goto url
  return browser
end

##
# Function that find and element type table
# element_name are required, execution are optional
# depending on the state of use
# Return: ok if the element exists, and nil if not found
def find_element_table(browser, element_name, execution=false, taskName)
  not_found = "element not found"
    #find element table
    if browser.th(visible_text: element_name).present?
      table_head = browser.th(visible_text: element_name)
      table_content = table_head.parent.parent.following_sibling
      puts table_head.text
    elsif browser.th.children(visible_text: element_name).present?
      table_head = browser.th.child(visible_text: element_name)
      table_content = table_head.parent.parent.parent.following_sibling
    else
      puts not_found
      return nil
    end
    unless execution == false
      #extract info, send to copy
       return copy(table_content, "table", taskName, element_name)
    end
    return 'ok'
end

##
# function that prepare the selenium object to extract the text
# first implementation just puts element.text
#
def copy(element, type, taskName, name_element, id=nil)

  load 'export_sheet.rb'
  #puts element.text
  #puts "claaaseee"
  if type == 'table'
    title = []
    title.push(name_element)
    table = []
    table.push(title)
    element.children.each do |child|
      rows = []
      child.children.each do |ch|
        #puts ch.text
        rows.push(ch.text)
      end
      table.push(rows)
    end
    puts "the table"
    print table
    return {table: newSheet(table, taskName)}
  else
    table = []
    rows = []
    rows.push(name_element)
    rows.push(element)
    table.push(rows)
    return {id: newSheet(table, taskName, id)}
  end
end

##
# function that found an clickable item (try with button, div, a, li and span)
# element_name are required, execution are optional
# depending on the state of use
# Return: ok if the element exists, and nil if not found
def find_element_button(browser, element_name, execution=false)
  button = nil
  not_found = "element not found"

    if browser.element(name: element_name).present?
      button = browser.element(name: element_name)
    elsif browser.element(id: element_name).present?
      button = browser.element(id: element_name)
    elsif browser.button(visible_text: element_name).present?
      button = browser.button(visible_text: element_name)
      puts button.text
    elsif browser.input(type: "submit", value: element_name).present?
      puts "aquí!"
      button = browser.input(type: "submit", value: element_name)
      puts button.value
    elsif browser.li(visible_text: element_name).present?
      button = browser.li(visible_text: element_name)
      puts button.text
    elsif browser.a(visible_text: element_name).present?
      button = browser.a(visible_text: element_name)
      puts button.text
    elsif browser.div(visible_text: element_name).present?
      button = browser.div(visible_text: element_name)
      puts button.text
    elsif browser.span(visible_text: element_name).present?
      button = browser.span(visible_text: element_name)
      puts button.text
    else
      #print not found if the element was not found
      puts not_found
      return nil
    end
  #click if the element found--function
  unless execution == false
    button.click
  end
  return "ok"
end

##
# two behaviours:
# first =  with execution variable is false: find all ids
#          for an input and returned in an array
# second = execuion true: find an element by his id and send
#          the values, return ok if no errors, nil otherwise
def find_element_text_input(browser, element_id=nil, text=nil, execution=false)
  puts execution
  ids = []
  if execution == false
    puts 'if'
    browser.text_fields.each do |input|
      puts input.name
      unless input.attribute_value(:name) == ""
        p 'aqui'
      #puts input.attribute_value(:name)
        ids.push(input.attribute_value(:name))
      end
    end
    return ids
  else
    puts 'no if'
    puts element_id
    input = browser.text_field(name: element_id)
    if input.exists?
      input.set(text)
      return "ok"
    else
      puts "no existe"
      return nil
    end
  end
end

##
# find an element by is id to copy his content
# only copy the content when the execution is true
def find_element_text(browser, element_id, execution=false, taskName, sheetId)
  puts 'execution:'
  puts sheetId
  puts execution
  if execution == false
    puts element_id
    text = browser.element(id: element_id)
    if text.exists?
      puts text.text
      return "ok"
    else
      puts "no existe"
      return nil
    end
  else
    text = browser.element(id: element_id)
    if text.exists?
      return copy(text.text, "text", taskName, element_id, sheetId)
    else
      return nil
    end
  end
end

##
# call the function required
# browser: the browser watir object that manage the web operaitons
#
def init_function(browser, type, name_or_id="", text=nil, execution=false, taskName, sheetId)
  puts 'type'
  puts type
  if type == 'Table'
    p 'gototable'
    return find_element_table(browser, name_or_id, execution, taskName)
  elsif type == 'Button'
    p 'gotobutton'
    return find_element_button(browser, name_or_id, execution)
  elsif type == 'Text_input'
    p 'gotoinput'
    puts name_or_id
    puts text
    puts execution
    return find_element_text_input(browser, name_or_id, text, execution)
  elsif type == 'Text'
    p 'gototext'
    return find_element_text(browser, name_or_id, execution, taskName, sheetId)
  end
  puts type
end

##
# Recieve a list wit all the arguments send by javascript.
# The first element are the url to make the work, the folowing elements are
# a dictionaries with the parameters to execute the function required"
# example:
#    [url, execution, {type: 'button', name_or_id:'PTOs - Foundations'},
#     {type: 'table', name_or_id: 'Student'}]
# if any of the functions fail, print an error, close the browser and retur nil
# if no errors, return ok
def constructor_function(elements, taskName=nil)

  url = elements.shift
  execution = elements.shift
  browser = setup_browser(url)
  puts 'browser_created'
  result = []
  sheetId = nil
  elements.each do |element|
    if element.has_key?(:elem_type)
      type = element[:elem_type]
    else
      type = element['elem_type']
    end
    name_or_id = nil
    text = nil
    if element.has_key?(:name_elem)
      name_or_id = element[:name_elem]
    elsif element.has_key?('name_elem')
      name_or_id = element['name_elem']
    end
    if element.has_key?(:text)
      text = element[:text]
    elsif element.has_key?('text')
      text = element['text']
    end
    puts 'go to init'
    result.unshift(init_function(browser, type, name_or_id, text, execution, taskName, sheetId))
    if result[0] == nil
      puts "Error"
      browser.close
      return nil
    end
    result.each do |r|
      if r.class == Hash
        sheetId = r[:id]
      end
    end
    puts ('ok')
  end
  sleep(2)
  browser.close
  return result
end

#end
#  browser.goto 'https://www.facebook.com/'
#  browser.goto 'file:///home/vagrant/tA/holberton/pto.html'
#  browser.goto 'http://www.ideam.gov.co/#'
#url = 'file:///home/vagrant/tA/holberton/pto.html'

=begin
url =  "www.google.com"
execution = false
response = [url, execution, {type: 'text_input', name_or_id: 'q', text: 'mafe'}, {type: 'button', name_or_id: "Buscar con Google"} ]
puts constructor_function(response)
=end

#find_element_table(ARGV[1], ARGV[0])
