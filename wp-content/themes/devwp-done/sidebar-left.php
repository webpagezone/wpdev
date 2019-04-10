<?php
	/**
	 * The Left Sidebar
	 *
	 * @link https://developer.wordpress.org/themes/basics/template-files/#template-partials
	 *
	 * @package DevWP
	 */

	if ( ! is_active_sidebar( 'left-sidebar' ) ) {
		return;
	}
?>

<div class="col-md-4 order-md-1 sidebar">
	<aside id="tertiary" class="widget-area theiaStickySidebar">
		<?php dynamic_sidebar( 'left-sidebar' ); ?>
	</aside>
</div>
