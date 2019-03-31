
<h2>Shipping  Ranges </h2>
<p> This page determines the ranges and charges used if your store is configured to charge shipping based on weight ranges, or charges if you store is configured to charge shipping based on cost. You can set your cart to use either a weight range or cost range in Store Settings &gt; Shipping Settings. </p>
<h3>Things to keep in mind</h3>
<h4>Overlaps</h4>
<p>  Ranges within a Shipping Method group should not over lap! The following example should be avoided. </p>
<table>
	<tr>
		<th>Method</th>
		<th>From</th>
		<th>To</th>
		<th> Rate</th>
	</tr>
	<tr>
		<td> USA UPS Ground </td>
		<td>0</td>
		<td>5</td>
		<td>5.00</td>
	</tr>
	<tr>
		<td>USA UPS Ground </td>
		<td>4</td>
		<td>10</td>
		<td>8.00</td>
	</tr>
</table>
<p>If the total weight/cost of the order came to 4.5   this would cause a problem because it fits into two different ranges.</p>
<h4>Gaps</h4>
<p> Just as important, you need to be sure there are no gaps in the  ranges like the following example. </p>
<table>
	<tr>
		<th>Method</th>
		<th>From</th>
		<th>To</th>
		<th> Rate</th>
	</tr>
	<tr>
		<td> USA UPS Ground </td>
		<td>0</td>
		<td>5</td>
		<td>5.00</td>
	</tr>
	<tr>
		<td>USA UPS Ground </td>
		<td>6</td>
		<td>10</td>
		<td>8.00</td>
	</tr>
</table>
<p>You can see in this example, if the total order weight/cost come to 5.5  there would be no shipping charge. </p>
<h4>The Right Way </h4>
<p> The following example shows the way weight/cost ranges should be set up, without any overlaps or gaps.</p>
<table>
	<tr>
		<th>Method</th>
		<th>From</th>
		<th>To</th>
		<th> Rate</th>
	</tr>
	<tr>
		<td> USA UPS Ground </td>
		<td>0</td>
		<td>5</td>
		<td>5.00</td>
	</tr>
	<tr>
		<td>USA UPS Ground </td>
		<td>5.01</td>
		<td>10</td>
		<td>8.00</td>
	</tr>
</table>
<h4>Covering The Top End</h4>
<p> One other point you should keep in mind is to prevent the possibility of going beyond the weight/cost ranges you have set up. For any defined method the last weight/cost range should be set with a &quot;To&quot; weight/cost that is high enough to prevent the likelihood of going over the range, like the following example.</p>
<table>
	<tr>
		<th>Method</th>
		<th>From</th>
		<th>To</th>
		<th> Rate</th>
	</tr>
	<tr>
		<td> USA UPS Ground </td>
		<td>100</td>
		<td>200</td>
		<td>35.00</td>
	</tr>
	<tr>
		<td>USA UPS Ground </td>
		<td>200.01</td>
		<td>10000000</td>
		<td>50.00</td>
	</tr>
</table>
<p>Naturally you would want to establish enough  Ranges for each method to cover any likely order weight/cost, then set the last  range to high figure to ensure you wont surpass it.</p>
<h4>Deleting Ranges</h4>
<p> You can delete and edit ranges any time you wish, just be sure not to inadvertently leave gaps or create overlaps. </p>
