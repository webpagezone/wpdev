<div class="navbar-wrapper">
	<!---<nav class="navbar navbar-inverse navbar-static-top roundCorner boxShadow" role="navigation">--->
	<nav class="navbar <!--- navbar-inverse --->navbar-default <!--- boxShadow --->" role="navigation">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
				<span class="sr-only">
					Toggle navigation
				</span>
				<span class="icon-bar">
				</span>
				<span class="icon-bar">
				</span>
				<span class="icon-bar">
				</span>
			</button>
		</div>
		<div id="navbar" class="navbar-collapse collapse">
			<cfmodule id="CW3Search"
			searchtype="boot_list"
			template="cw3/CWTags/CWTagSearch.cfm"
			allcategorieslabel="All Products"
			separator="|"
			selectedstart="&lt;span style=""font-weight: bold;""&gt;"
			selectedend="&lt;/span&gt;">
		</div>
	</nav>
</div>
