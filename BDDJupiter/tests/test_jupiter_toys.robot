*** Settings ***

Resource    ../resources/environment_variables.robot
Resource    ../resources/libraries.robot
Resource    ../resources/page_objects/contacts.robot
Resource    ../resources/page_objects/shopPage.robot

Test Setup        Open Jupiter Toys Page Using Chrome Browser
Test Teardown     Close Browser


*** Test Cases ***
Test Case Scenario# 0 :Test Run
  [tags]  Smoke
  [Template]  The user populates the required fields
  This is the first execution variable  x1
  This is the second execution          x2
  This is the first execution variable  x3
  This is the fourth execution          x4
  This is the fifth execution variable  x5
  This is the sixth execution           x6

Test Case Scenario# 1 : Validate that error handling messages should be displayed when not populating the required fields
  [tags]  Smoke
  GIVEN The user goes to the contact page
  AND On the contact page the user clicks submit
  AND Error messages for required field should be displayed
  WHEN The user populates the mandatory fields
  THEN Error messages caused by not populating the fields should be gone

Test Case Scenario# 2 : Validate successful submission message
   [tags]  Smoke
   [Template]  Verify successful message submission for the Contact Page
   #Forename #Email             #Message
   Sasuke    Sasuke@konoha.com  Hi
   Itachi    Itachi@konoha.com  Hi
   Madara    Madara@konoha.com  Hi
   Shisui    Shisui@konoha.com  Hi
   Obito     Obito@konoha.com   Hi

Test Case Scenario# 3 : Validate that the correctness of subtotal for each product, price per product, and total amount
  [Tags]  Smoke
  [Template]  Validate that values should be correct for the subtotal for each product,price per unit, and total amount
  #Product #Number of units  #Expected subtotal #Price per unit  #Expected total during run
  Stuffed Frog  2  $21.98  $10.99  $21.98
  Fluffy Bunny  5  $49.95  $9.99  $71.93
  Valentine Bear  3  $44.97  $14.99  $116.9

Test Case Scenario# 4 : Validate that a user can successfully checkout a product
  [tags]  Smoke  AdhocScenario
  GIVEN The user goes to the shop page
  When The user chooses an item
  AND Goes to the cart and clicks Check Out
  AND Populates the payment details and clicks the submit button
  THEN Order should be successfully accepted

*** Keywords ***
Verify successful message submission for the Contact Page
    [Arguments]    ${forename}  ${email}  ${message}
    The user goes to the contact page
    Input Text                         ${user_forename_locator_tc1}   ${forename}
    Input Text                         ${user_email_tc1}     ${email}
    Input Text                         ${user_message_tc1}   ${message}
    Log                                Used variables: ${forename} and ${email} and ${message}
    Scroll Element Into View           ${submit_element}
    Mouse Down                         ${submit_element}
    Click Element                      ${submit_element}
    Wait Until Element Is Not Visible  ${popup_modal_sending}  timeout=${timeout}
    Wait Until Element Is Visible      ${contact_valid_submit}  timeout=${timeout}
    Wait Until Element Is Not Visible   ${sending_feedback_modal}  timeout=${timeout}
    Wait Until Page Contains Element    ${back_button}  timeout=${timeout}
    Click Element                      ${back_button}

Validate that values should be correct for the subtotal for each product,price per unit, and total amount
    [Arguments]  ${product}  ${numberofunits}  ${expectedsubtotal}  ${expectedpriceperunit}  ${expectedtotal}
    Click Link  ${shop_link}
    Wait Until Element Is Visible      //h4[contains(text(),'${product}')]/following-sibling::p/a[contains(text(),'Buy')]  timeout=${timeout}
    Repeat Keyword    ${numberofunits} times    Click Element    //h4[contains(text(),'${product}')]/following-sibling::p/a[contains(text(),'Buy')]
    Click Element  ${cart_link}
    #Assertion for subtotal
    Wait Until Element Is Visible      //td[contains(text(),'${product}')]/following-sibling::td[3]  timeout=${timeout}
    ${actualpriceproduct}=    Get Text    //td[contains(text(),'${product}')]/following-sibling::td[3]
    Should Be Equal    ${expectedsubtotal}    ${actualpriceproduct}
    #Assert Price Per Unit
    Wait Until Element Is Visible      //td[contains(text(),'${product}')]/following-sibling::td[1]  timeout=${timeout}
    ${actualpriceperunit}=    Get Text    //td[contains(text(),'${product}')]/following-sibling::td[1]
    Should Be Equal    ${expectedpriceperunit}    ${actualpriceperunit}
    #Assert Total Amount
    ${actualtotalamount}=    Get Text    ${actual_tot_amt_location}
    Click Element    ${shop_element}
    Log    Used variables: ${product} and ${numberofunits} and ${expectedsubtotal} and ${expectedpriceperunit} and ${expectedtotal}
    Click Element    ${cart_link}
    ${expectedtotal}=    Remove String        ${expectedtotal}   ,    $
    Should Be Equal    Total: ${expectedtotal}    ${actualtotalamount}

The user populates the required fields
    [Arguments]    ${templateVar1}  ${templateVar2}
    Log    Used variables: ${templateVar1} and ${templateVar2}

Error messages for required field should be displayed
    Wait Until Page Contains Element     ${header}  timeout=${timeout}
    Wait Until Page Contains Element     ${user_forename_locator_tc1_error}  timeout=${timeout}
    Wait Until Page Contains Element     ${user_email_locator_tc1_error}  timeout=${timeout}
    Wait Until Page Contains Element     ${user_message_locator_tc1_error}  timeout=${timeout}

The user populates the mandatory fields
    Input Text    ${user_forename_locator_tc1}    ${user_forename_value_tc1}
    Input Text    ${user_email_tc1}     ${user_email_value_tc1}
    Input Text    ${user_message_tc1}  ${user_message_value_tc1}

Error messages caused by not populating the fields should be gone
    Wait Until Page Contains Element     ${header}
    Element Should Not Be Visible        ${user_forename_locator_tc1_error}
    Element Should Not Be Visible        ${user_email_locator_tc1_error}
    Element Should Not Be Visible        ${user_message_locator_tc1_error}

On the contact page the user clicks submit
    Click Link                             ${submit_link}

The user goes to the contact page
    Click Element                          ${contact_element}
    Wait Until Page Contains Element       ${contact_header_section}

The user goes to the shop page
    Click Link                             ${shop_link}

The user chooses an item
    Wait Until Element Is Visible     ${product_bear_element}    timeout=${timeout}
    Click Element    ${product_bear_element}
    Click Element  ${cart_link}

Goes to the cart and clicks Check Out
    Click Element  ${cart_link}
    Wait Until Element Is Visible    ${check_out_element}  timeout=${timeout}
    Click Link    ${check_out_link}

Populates the payment details and clicks the submit button
    Wait Until Element Is Visible    ${delivery_details_element}   timeout=${timeout}
    Input Text    ${user_forename_locator_tc4}    ${user_forename_value_tc4}
    Input Text    ${user_email_tc4}     ${user_email_value_tc4}
    Input Text    ${user_address_tc4}  ${user_address_value_tc4}
    Select From List By Value    ${card_type_element}  ${mastercard}
    Input Text    ${card_num_field_element}    ${card_num}
    Click Element    ${shop_submit_btn}

Order should be successfully accepted
    Wait Until Element Is Not Visible   ${shop_modal_element}   timeout=${timeout}
    Element Should Contain    ${shop_success_element}    ${shop_success_expected_value}

Open Jupiter Toys Page Using Chrome Browser
    ##comment/uncomment to enable testing with browser
#    Open Browser	${MAIN_PAGE}  ${Chrome}
#    Maximize Browser Window

    #comment/uncomment to enable testing using headless browser
   ${options}       Evaluate    sys.modules['selenium.webdriver'].FirefoxOptions()
   Call Method  ${options}  add_argument  -headless
   Create Webdriver  ${Firefox}  options=${options}
   Go To    ${MAIN_PAGE}
   Maximize Browser Window





