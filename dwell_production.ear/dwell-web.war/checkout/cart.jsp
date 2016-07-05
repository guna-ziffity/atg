<dsp:page>
<link rel="stylesheet" href="/dwellstore/css/styles.css" type="text/css" media="screen" title="no title" charset="utf-8" />
<link rel="stylesheet" href="/dwellstore/css/screen.css" type="text/css" media="screen" title="no title" charset="utf-8" />
<body class=" cms-index-index cms-home">
<div class="wrapper">
<div class="page">
<dsp:importbean bean="/atg/commerce/order/purchase/CartModifierFormHandler" />
<dsp:importbean bean="/atg/commerce/ShoppingCart"/>
<dsp:include page="/includes/header.jsp" />
<div class="main col1-layout">
<div class="col-main">
<dsp:include page="cartItem.jsp" >
<dsp:param name="commerceItems" bean="ShoppingCart.current.commerceItems"/>
</dsp:include>
</div>
</div>
</div>
<dsp:include page="/includes/footer.jsp" />
</div>
</body>
</dsp:page>