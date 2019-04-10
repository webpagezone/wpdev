<?php
	/**
	 * The Front Page Template File
	 *
	 * @link https://developer.wordpress.org/themes/basics/template-hierarchy/
	 *
	 * @package DevWP
	 */

	get_header();
	$containerType         = get_theme_mod( 'devwp_container_type' );
	$navbarType            = get_theme_mod( 'devwp_navbar_type' );
	$devwp_sidebar_options = get_theme_mod( 'devwp_sidebar_options' );
	//	In order to keep the if conditionals short, I'm creating variables.
	$ffesb = is_active_sidebar( 'front-full-edge' );
	$ffcsb = is_active_sidebar( 'front-full-centered' );

	if ( is_active_sidebar( 'front-full-centered' ) ) : ?>
		<div class="row my-1">
			<div class="col-md-12">
				<?php dynamic_sidebar( 'front-full-centered' ); ?>
			</div>
		</div>
	<?php endif;

	if ( is_active_sidebar( 'fp-container' ) ) : ?>
				<?php dynamic_sidebar( 'fp-container' ); ?>
	<?php endif; ?>

<?php if ( is_active_sidebar( 'one-third-1' ) || is_active_sidebar( 'one-third-2' ) || is_active_sidebar( 'one-third-3' ) )    : ?>
	<div class="row my-1">

		<div class="col-md-4 my-1">
			<?php dynamic_sidebar( 'one-third-1' ); ?>
		</div>
		<!-- col-md-4-->
		<div class="col-md-4 my-1">
			<?php dynamic_sidebar( 'one-third-2' ); ?>
		</div>
		<!-- col-md-4-->
		<div class="col-md-4 my-1">
			<?php dynamic_sidebar( 'one-third-3' ); ?>
		</div>
		<!-- col-md-4-->
	</div>
	<!-- row -->
<?php endif; ?>

	<div id="content" class="site-content mt-2 row">

<?php
if ( $devwp_sidebar_options == 'right' || $devwp_sidebar_options == 'left' ) {
	?>
	<div id="primary" class="content-area col-md-8 <?php if ( 'left' == $devwp_sidebar_options ) {
		echo ' order-md-2';
	} ?>">
	<main id="main" class="site-main theiaStickySidebar">
	<?php } elseif ( $devwp_sidebar_options == 'none' ) { ?>
	<div id="primary" class="content-area col-md-12">
	<main id="main" class="site-main">
<?php }

	$args         = array(
		'post_type'      => 'post',
		'posts_per_page' => '5',
		'post__not_in'   => get_option( 'sticky_posts' ),
	);
	$custom_query = new WP_Query( $args );
	if ( $custom_query->have_posts() ) :
		while ( $custom_query->have_posts() ) :
			$custom_query->the_post();
			?>
			<a class="post-thumbnail" href="<?php the_permalink(); ?>" aria-hidden="true">
				<?php
					the_post_thumbnail( 'post-thumbnail', array(
						'alt' => the_title_attribute( array(
							'echo' => false,
						) ),
					) );
				?>
			</a>

			<h2 class="entry-title">
				<a href="<?php the_permalink(); ?>" title="<?php the_title_attribute(); ?>"><?php the_title(); ?></a>
			</h2>
			<?php
			echo "<div class='entry-meta'>";
			devwp_posted_on();
			devwp_posted_by();
			echo "</div>";
			the_excerpt();
			echo "<hr>";

		endwhile;

	endif;
	wp_reset_postdata();

?>
	</main>
	<!-- #main -->
	</div>
	<!-- #primary -->
<?php
	if ( $devwp_sidebar_options == 'right' ) {
		get_sidebar();
	} elseif ( $devwp_sidebar_options == 'left' ) {
		get_sidebar( 'left' );
	}
	get_footer();
