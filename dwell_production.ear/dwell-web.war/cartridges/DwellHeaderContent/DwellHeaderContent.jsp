<dsp:page>
<head>
    <style type="text/css">
       a:link {color: black;}      / unvisited link /
       a:visited {color: black;}   / visited link /
       a:hover {color: red;}     / mouse over link /
       a:active {color: black;}    / selected link /
       a:nounderline {text-decoration: none;}
    </style>
</head>
  <dsp:importbean bean="/OriginatingRequest" var="originatingRequest"/>
  <div class="branding">
  	<dsp:getvalueof var="contentItem" vartype="com.endeca.infront.assembler.ContentItem" value="${originatingRequest.contentItem}"/>
    <h1 class="logo"><dsp:a href="/dwellstore"><img src="/dwellstore/images/${contentItem.Logo}" /></dsp:a></li>
  </div>
  <div class="form-search">
  	<div class="form-search-inner">
  		<div id="search-form" class="search-form">
  			<dsp:renderContentItem contentItem="${contentItem.SearchBox}" />
  		</div>
  	</div>
  </div>
  <div class="nav-container" style="float:none;">
  	<div id="top-nav" class="top-nav right">
		<ul class="right">
  			<c:forEach var="content" items="${contentItem.HeaderContent}">
  				<li><a href="${content.LinkName}.jsp" style="text-decoration:none">${content.LinkName}</a></li>
  			</c:forEach>
  		</ul>
  	</div>
  </div>
 </dsp:page>