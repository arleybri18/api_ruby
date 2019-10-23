require 'watir'
require 'webdrivers'
##
# Function that setup the watir browser
#
def setup_browser(url)
  browser = Watir::Browser.new :firefox, headless: false
  browser.goto url
  return browser
end

##
# Function that find and element type table
# element_name are required, execution are optional
# depending on the state of use
# Return: ok if the element exists, and nil if not found
def find_element_table(browser, element_name, execution=false)

  not_found = "element not found"
    #find element table
    if browser.th(visible_text: element_name).present?
      table_head = browser.th(visible_text: element_name)
      puts table_head.text

      unless execution == false
        #extract info, send to copy
        table_content = table_head.parent.parent.following_sibling
        copy(table_content)
      end
      return "ok"
    else
      puts not_found
      return nil
    end
end

##
# function that prepare the selenium object to extract the text
# first implementation just puts element.text
#
def copy(element)
  puts element.text
end

##
# function that found an clickable item (try with button, div, a, li and span)
# element_name are required, execution are optional
# depending on the state of use
# Return: ok if the element exists, and nil if not found
def find_element_button(browser, element_name, execution=false)
  button = nil
  not_found = "element not found"

    if browser.button(visible_text: element_name).present?
      button = browser.button(visible_text: element_name)
      puts button.text
    elsif browser.input(type: "submit", value: element_name)
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
  ids = []
  if execution == false
    browser.text_fields().each do |input|
      unless input.attribute_value(:name) == ""
        p 'aqui'
      #puts input.attribute_value(:name)
        ids.push(input.attribute_value(:name))
      end
    end
    return ids
  else
    input = browser.text_field(name: element_id)
    if input.exists?
      input.set(text)
      return "ok"
    else
      put "no existe"
      return nil
    end
  end
end

##
# find an element by is id to copy his content
# only copy the content when the execution is true
def find_element_text(browser, element_id, execution=false)
  if execution == false
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
      copy(text)
      return "ok"
    else
      return nil
    end
  end
end

##
# call the function required
# browser: the browser watir object that manage the web operaitons
#
def init_function(browser, type, name_or_id=nil, text=nil, execution=false)
  puts type
  if type == 'table'
    p 'gototable'
    return find_element_table(browser, name_or_id, execution)
  elsif type == 'button'
    p 'gotobutton'
    return find_element_button(browser, name_or_id, execution)
  elsif type == 'text_input'
    p 'gotoinput'
    return find_element_text_input(browser, name_or_id, text, execution)
  elsif type == 'text'
    p 'gototext'
    return find_element_text(browser, name_or_id, execution)
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
def constructor_function(elements)

  url = elements.shift
  execution = elements.shift
  browser = setup_browser(url)
  result = nil
  elements.each do |element|
    type = element[:type]
    name_or_id = nil
    text = nil
    if element.has_key?(:name_or_id)
      name_or_id = element[:name_or_id]
    end
    if element.has_key?(:text)
      text = element[:text]
    end
    result = init_function(browser, type, name_or_id, text, execution)
    if result == nil
      puts "Error"
      browser.close
      return nil
    end
  end
  sleep(2)
  return result
end

#  browser.goto 'https://www.facebook.com/'
#  browser.goto 'file:///home/vagrant/tA/holberton/pto.html'
#  browser.goto 'http://www.ideam.gov.co/#'
#url = 'file:///home/vagrant/tA/holberton/pto.html'
url =  "www.google.com"
execution = false
response = [url, execution, {type: 'text_input', name_or_id: 'q', text: 'mafe'}, {type: 'button', name_or_id: "Buscar con Google"} ]
puts constructor_function(response)
#find_element_table(ARGV[1], ARGV[0])
