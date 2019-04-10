<?php
	/**
	 * The sidebar containing the main widget area
	 *
	 * @link https://developer.wordpress.org/themes/basics/template-files/#template-partials
	 *
	 * @package DevWP
	 */

	if ( ! is_active_sidebar( 'right-sidebar' ) ) {
		return;
	}
?>

<div class="col-md-4 sidebar pt-1">
	<aside id="secondary" class="widget-area theiaStickySidebar">
		<?php dynamic_sidebar( 'right-sidebar' ); ?>
	</aside>
</div>
