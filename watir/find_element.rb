require 'watir'
require 'webdrivers'
##
# Function that setup the watir browser
#
def setup_browser(url)
  browser = Watir::Browser.new :firefox, headless: true
#  browser.goto 'https://www.facebook.com/'
#  browser.goto 'file:///home/vagrant/tA/holberton/pto.html'
#  browser.goto 'http://www.ideam.gov.co/#'
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
      browser.close
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
      browser.close
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
def find_element_input(browser, element_id=nil, text=nil, execution=false)
  ids = []
  if execution == false
    browser.inputs().each do |input|
      unless input.id == ""
        ids.push(input.id)
      end
    end
    return ids
  else
    input = browser.text_field(id: element_id)
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
# call the function required, not finished yet
#
def init_function(url, p1, p2=false, p3=false)
  browser = setup_browser(url)
  find_element_text(browser, p1)
end

puts init_function(ARGV[0], ARGV[1])
#find_element_table(ARGV[1], ARGV[0])
