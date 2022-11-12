*** Variables ***
${contact_element}  //a[normalize-space()='Contact']
${contact_header_section}  //strong[normalize-space()='We welcome your feedback']
${submit_link}  Submit
${submit_element}  //a[contains(text(), "Submit")]
${user_forename_locator_tc1}  //input[@id='forename']
${user_forename_value_tc1}  Uzumaki
${user_email_tc1}  //input[@type='email']
${user_email_value_tc1}  Naruto@konoha.com
${user_message_tc1}  //textarea[@type='text']
${user_message_value_tc1}  Hi
${header}  //strong[normalize-space()='We welcome your feedback']
${user_forename_locator_tc1_error}  //span[@ui-if='form.forename.$dirty && form.forename.$error.required']
${user_email_locator_tc1_error}  //span[@ui-if='form.email.$dirty && form.email.$error.required']
${user_message_locator_tc1_error}  //span[@ui-if='form.message.$dirty && form.message.$error.required']
${popup_modal_sending}  //div[@class='popup modal hide ng-scope']
${popup_modal_timeout}  timeout=30s
${contact_valid_submit}  //div[@ui-if='contactValidSubmit']//div
${contact_valid_submit_timeout}  timeout=20s
${back_button}  //a[normalize-space()='« Back']
${sending_feedback_modal}  //h1[normalize-space()='Sending Feedback']

