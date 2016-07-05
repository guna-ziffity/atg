<dsp:page>
 
<dsp:importbean bean="/atg/commerce/order/purchase/CreateCreditCardFormHandler"/>
<dsp:importbean bean="/atg/userprofiling/Profile"/>

<hr><p>Enter new CreditCard information

<dsp:form action="billing.jsp" method="post">
<table>
<tr><td>
CreditCard NickName </td> <td>:<dsp:input
bean="CreateCreditCardFormHandler.creditCardName" type="text"
value=""/></td>
</tr>
<tr><td>
CreditCardNumber </td> <td>:<dsp:input
bean="CreateCreditCardFormHandler.creditCard.creditCardNumber"
maxsize="20" size="20" type="text" value="4111111111111111"/>
</td>
</tr>
<tr><td>CreditCardType </td><td>
:<dsp:select bean="CreateCreditCardFormHandler.creditCard.creditCardType"
required="<%=true%>">
<dsp:option value="Visa">Visa</dsp:option>
<dsp:option value="MasterCard">Master Card</dsp:option>
<dsp:option value="American Express">American Express</dsp:option>
</dsp:select>
</td></tr>

<tr><td>
Expiration Details </td> <td>:<dsp:select 
bean="CreateCreditCardFormHandler.creditCard.expirationMonth">
<dsp:option value="1">January</dsp:option>
<dsp:option value="2">February</dsp:option>
<dsp:option value="3">March</dsp:option>
<dsp:option value="4">April</dsp:option>
<dsp:option value="5">May</dsp:option>
<dsp:option value="6">June</dsp:option>
<dsp:option value="7">July</dsp:option>
<dsp:option value="8">August</dsp:option>
<dsp:option value="9">September</dsp:option>
<dsp:option value="10">October</dsp:option>
<dsp:option value="11">November</dsp:option>
<dsp:option value="12">December</dsp:option>
</dsp:select>

<dsp:select bean="CreateCreditCardFormHandler.creditCard.expirationYear">
<dsp:option value="2002">2002</dsp:option>
<dsp:option value="2003">2003</dsp:option>
<dsp:option value="2004">2004</dsp:option>
<dsp:option value="2005">2005</dsp:option>
<dsp:option value="2006">2006</dsp:option>
<dsp:option value="2007">2007</dsp:option>
<dsp:option value="2008">2008</dsp:option>
<dsp:option value="2009">2009</dsp:option>
<dsp:option value="2010">2010</dsp:option>
</dsp:select>
</td></tr>
<tr><td>
First Name: </td><td><dsp:input
bean="CreateCreditCardFormHandler.creditCard.billingAddress.firstName"
beanvalue="Profile.firstName" size="30" type="text"/>
</td></tr>
<tr><td>
Last Name: </td><td><dsp:input
bean="CreateCreditCardFormHandler.creditCard.billingAddress.lastName"
beanvalue="Profile.lastName" size="30" type="text"/>
</td></tr>
<tr><td>
Address: </td><td><dsp:input
bean="CreateCreditCardFormHandler.creditCard.billingAddress.address1"
beanvalue="Profile.billingAddress.address1" size="30" type="text"/>
</td></tr>
<tr><td>
City: </td><td><dsp:input
bean="CreateCreditCardFormHandler.creditCard.billingAddress.city"
beanvalue="Profile.billingAddress.city" size="30" type="text"/>
</td></tr>
<tr><td>
State: </td><td><dsp:input
bean="CreateCreditCardFormHandler.creditCard.billingAddress.state"
beanvalue="Profile.billingAddress.state" size="30" type="text"/>
</td></tr>
<tr><td>
Postal code: </td><td><dsp:input
bean="CreateCreditCardFormHandler.creditCard.billingAddress.postalCode"
beanvalue="Profile.billingAddress.postalCode" size="30" type="text"/>
</td></tr>
<tr><td>
Country: </td><td><dsp:input
bean="CreateCreditCardFormHandler.creditCard.billingAddress.country"
beanvalue="Profile.billingAddress.country" size="30" type="text"/>
</td></tr>

</table>
<dsp:input bean="CreateCreditCardFormHandler.newCreditCardSuccessURL"
type="hidden" value="billing.jsp?init=false"/>
<dsp:input bean="CreateCreditCardFormHandler.newCreditCardErrorURL"
type="hidden" value="billing.jsp"/>
<dsp:input bean="CreateCreditCardFormHandler.newCreditCard" type="submit"
value="Use Credit Card"/>

</dsp:form>

</dsp:page>