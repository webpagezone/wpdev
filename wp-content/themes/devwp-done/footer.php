<?php
	/**
	 * The template for displaying the footer
	 *
	 * Contains the closing of the #content div and all content after.
	 *
	 * @link https://developer.wordpress.org/themes/basics/template-files/#template-partials
	 *
	 * @package DevWP
	 */
	$containerType = get_theme_mod( 'devwp_container_type' );

?>
</div> <!-- #content -->
</div> <!-- .container -->

<div class="site-footer">
<div class="<?php echo esc_attr( $containerType ); ?>">
	<footer id="colophon">
		<?php if ( is_active_sidebar( 'footer-left' ) || is_active_sidebar( 'footer-middle' ) || is_active_sidebar( 'footer-right' ) )    : ?>
			<div class="row pt-3">
				<div class="col-md-4">
					<?php dynamic_sidebar( 'footer-left' ); ?>

				</div>
				<div class="col-md-4">
					<?php dynamic_sidebar( 'footer-middle' ); ?>

				</div>
				<div class="col-md-4">
					<?php dynamic_sidebar( 'footer-right' ); ?>
				</div>
			</div>
			<!-- row -->
		<?php endif; ?>
		<div class="row">
			<div class="site-info col-md-12 py-3">

				<?php devwp_social_menu(); ?>

				<a href="<?php echo esc_url( __( 'https://wordpress.org/', 'devwp' ) ); ?>">
					<?php
						/* translators: %s: CMS name, i.e. WordPress. */
						printf( esc_html__( 'Proudly Powered by %s', 'devwp' ), 'WordPress' );
					?>
				</a>
				<span class="sep"> | </span>
				<a href="<?php echo esc_url( __( 'https://www.pixemweb.com/devwp/', 'devwp' ) ); ?>">
					<?php printf( esc_html__( 'DevWP Theme By: %s', 'devwp' ), 'PixemWeb' ); ?>
				</a>
			</div>
			<!-- .site-info -->
		</div>
		<!-- row -->
	</footer>
</div> <!-- container -->
</div>
</div> <!-- #page -->

<?php wp_footer(); ?>

</body>
</html>
