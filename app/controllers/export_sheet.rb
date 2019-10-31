require "google/apis/sheets_v4"
require "googleauth"
require "googleauth/stores/file_token_store"
require "fileutils"
require "json"

credentials = File.join(Rails.root, 'app', 'controllers', 'credentials.json')
puts 'credentisl done'
token = File.join(Rails.root, 'app', 'controllers', 'token.yaml')
OOB_URI = "urn:ietf:wg:oauth:2.0:oob".freeze
APPLICATION_NAME = "Google Sheets API Ruby autotask".freeze
CREDENTIALS_PATH = credentials.freeze
# The file token.yaml stores the user's access and refresh tokens, and is
# created automatically when the authorization flow completes for the first
# time.
TOKEN_PATH = token.freeze
SCOPE = Google::Apis::SheetsV4::AUTH_DRIVE

##
# Ensure valid credentials, either by restoring from the saved credentials
# files or intitiating an OAuth2 authorization. If authorization is required,
# the user's default browser will be launched to approve the request.
#
# @return [Google::Auth::UserRefreshCredentials] OAuth2 credentials
def authorize
  client_id = Google::Auth::ClientId.from_file CREDENTIALS_PATH
  token_store = Google::Auth::Stores::FileTokenStore.new file: TOKEN_PATH
  authorizer = Google::Auth::UserAuthorizer.new client_id, SCOPE, token_store
  user_id = "default"
  credentials = authorizer.get_credentials user_id
  if credentials.nil?
    url = authorizer.get_authorization_url base_url: OOB_URI
    puts "Open the following URL in the browser and enter the " \
         "resulting code after authorization:\n" + url
    code = gets
    credentials = authorizer.get_and_store_credentials_from_code(
      user_id: user_id, code: code, base_url: OOB_URI
    )
  end
  credentials
end
puts 'ok'
##
# Create a Google Sheet file with the information of the table format :
# [[data1, data2...], [data3, data4, ....], .... ]
# Return  
def newSheet(table, taskName, id)
  # open the Google Sheet service
  service = Google::Apis::SheetsV4::SheetsService.new
  service.client_options.application_name = APPLICATION_NAME
  service.authorization = authorize

  # open the Google Drive service
  drive = Google::Apis::DriveV3::DriveService.new
  drive.client_options.application_name = APPLICATION_NAME
  drive.authorization = authorize

  if id == nil
    #create a new sheet
    spreadsheet = {
      properties: {
        title: taskName
      }
    }
    spreadsheet = service.create_spreadsheet(spreadsheet,
                                             fields: 'spreadsheetId')
    puts "Spreadsheet ID: #{spreadsheet.spreadsheet_id}"
    #fill the sheet with the data 'table'
    data = [
            {
              range: 'A:C',
              majorDimension: "ROWS",
              values: table,
            }
           ]
    value_range_object = Google::Apis::SheetsV4::ValueRange.new(range: 'A:C',
                                                                majorDimension: "ROWS",
                                                                values: table)
    result = service.update_spreadsheet_value(spreadsheet.spreadsheet_id,
                                              'A:C',
                                              value_range_object,
                                              value_input_option: 'RAW')
    puts = "#{result.updated_cells} cells updated."
    file = drive.get_file(spreadsheet.spreadsheet_id)
    puts "Create this file name: #{file.name}"
    id = spreadsheet.spreadsheet_id
  else
    file = drive.get_file(id[:id])
    #geting the info of the sheet
    get_celds = service.get_spreadsheet_values(id[:id], 'A:C')
    puts get_celds.range
=begin
    value_range_object = Google::Apis::SheetsV4::ValueRange.new(range: 'A:C',
                                                                majorDimension: "ROWS",
                                                                values: table)
    result = service.update_spreadsheet_value(spreadsheet.spreadsheet_id,
                                              'A:C',
                                              value_range_object,
                                              value_input_option: 'RAW')
=end    
    puts "Updating this: #{file.name}"

##
# change the permision of the created file
# line in google-api-ruby-client/lib/google/apis/core/api_command.rb return {} and make and error.
# self.body = request_representation.new(request_object).to_json(user_options: { skip_undefined: true })
#

=begin
  data = 
    {
      "role" => "writer",
      "type" => "anyone"
    }
#  byebug
  permision = drive.create_permission(id, data.to_json,
                                      options: {skip_serialization: true})

  link = "https://docs.google.com/spreadsheets/d/#{file.id}"
  puts "use this link: #{link}"

  return link
end
=end
