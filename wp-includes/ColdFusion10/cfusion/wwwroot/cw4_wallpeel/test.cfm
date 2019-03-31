	<cfquery name="rsCats" datasource="webpage1_cw4wp_ds"
		username="webpage1_cw4wp" password="S@tmar00!">
		SELECT *


		FROM cw_categories_primary
	</cfquery>

	<cfdump var="#rsCats#">