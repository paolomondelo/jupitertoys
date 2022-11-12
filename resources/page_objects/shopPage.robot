*** Variables ***
${shop_link}  Shop
${shop_element}  //a[normalize-space()='Shop']
${cart_link}  //a[@href='#/cart']
${actual_tot_amt_location}  //strong[@class='total ng-binding']
${check_out_element}  //a[normalize-space()='Check Out']
${check_out_link}  Check Out
${user_forename_locator_tc4}  //input[@id='forename']
${user_forename_value_tc4}  Uzumaki
${user_email_tc4}  //input[@type='email']
${user_email_value_tc4}  Naruto@konoha.com
${user_address_tc4}  //textarea[@id='address']
${user_address_value_tc4}  Konoha Nation
${card_num}  4111111111111111
${product_bear_element}  //h4[contains(text(),'Teddy Bear')]/following-sibling::p/a[contains(text(),'Buy')]
${delivery_details_element}  //legend[normalize-space()='Delivery Details']
${card_type_element}  //select[@id='cardType']
${mastercard}  Mastercard
${card_num_field_element}  //input[@id='card']
${shop_submit_btn}  checkout-submit-btn
${shop_modal_element}  //div[@class='modal-header']
${shop_success_element}  //div[@class='alert alert-success']
${shop_success_expected_value}  order has been accepted

