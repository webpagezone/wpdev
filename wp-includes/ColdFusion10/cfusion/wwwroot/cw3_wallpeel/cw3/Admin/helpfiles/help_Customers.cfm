<h2>Customer List </h2>
 
	<p> This page allows you to search for customers by the first letter in their
		last name, by Zip Code and by Order number. Both the Zip Search and the Order
		number searches are &quot;fuzzy&quot; searches, meaning that you can type in
		the first few numbers and the search will bring back records that start
		with the data you entered. The more data you enter the narrower the search
		will be.</p> 
	<p>The results returned are the closest matches to the search data you entered
		sorted alphabetically and displayed in a table format. The links available
		are a link to the <a href="<cfoutput>#request.ThisPage#</cfoutput>?HelpFileName=CustomerDetails.cfm">Customer
		Details</a> page and an email link that will launch your default email program
		with the customer's email address. </p> 
