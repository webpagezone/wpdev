<?php

	/**
	 * Register widget area.
	 *
	 * @link https://developer.wordpress.org/themes/functionality/sidebars/#registering-a-sidebar
	 */
	function devwp_widgets_init() {
		register_sidebar( array(
			'name'          => esc_html__( 'Right Sidebar', 'devwp' ),
			'id'            => 'right-sidebar',
			'description'   => esc_html__( 'Add widgets here.', 'devwp' ),
			'before_widget' => '<section id="%1$s" class="widget %2$s">',
			'after_widget'  => '</section>',
			'before_title'  => '<h2 class="widget-title">',
			'after_title'   => '</h2>',
		) );

		register_sidebar( array(
			'name'          => esc_html__( 'Left Sidebar', 'devwp' ),
			'id'            => 'left-sidebar',
			'description'   => esc_html__( 'Add widgets here.', 'devwp' ),
			'before_widget' => '<section id="%1$s" class="widget %2$s">',
			'after_widget'  => '</section>',
			'before_title'  => '<h2 class="widget-title">',
			'after_title'   => '</h2>',
		) );

		register_sidebar( array(
			'name'          => esc_html__( 'Front Page Edge to Edge', 'devwp' ),
			'id'            => 'front-full-edge',
			'description'   => esc_html__( 'Add widgets here.', 'devwp' ),
			'before_widget' => '<section id="%1$s" class="widget %2$s">',
			'after_widget'  => '</section>',
			'before_title'  => '<h2 class="widget-title">',
			'after_title'   => '</h2>',
		) );

		register_sidebar( array(
			'name'          => esc_html__( 'Front Page Full Centered', 'devwp' ),
			'id'            => 'front-full-centered',
			'description'   => esc_html__( 'Add widgets here.', 'devwp' ),
			'before_widget' => '<section id="%1$s" class="widget %2$s">',
			'after_widget'  => '</section>',
			'before_title'  => '<h2 class="widget-title">',
			'after_title'   => '</h2>',
		) );
		register_sidebar( array(
			'name'          => esc_html__( 'Front Page Empty Container', 'devwp' ),
			'id'            => 'fp-container',
			'description'   => esc_html__( 'Add widgets here.', 'devwp' ),
			'before_widget' => '<section id="%1$s" class="widget %2$s">',
			'after_widget'  => '</section>',
			'before_title'  => '<h2 class="widget-title">',
			'after_title'   => '</h2>',
		) );
		register_sidebar( array(
			'name'          => esc_html__( 'FP: One Third 1 ', 'devwp' ),
			'id'            => 'one-third-1',
			'description'   => esc_html__( 'Add widgets here.', 'devwp' ),
			'before_widget' => '<section id="%1$s" class="widget %2$s">',
			'after_widget'  => '</section>',
			'before_title'  => '<h2 class="widget-title">',
			'after_title'   => '</h2>',
		) );
		register_sidebar( array(
			'name'          => esc_html__( 'FP: One Third 2', 'devwp' ),
			'id'            => 'one-third-2',
			'description'   => esc_html__( 'Add widgets here.', 'devwp' ),
			'before_widget' => '<section id="%1$s" class="widget %2$s">',
			'after_widget'  => '</section>',
			'before_title'  => '<h2 class="widget-title">',
			'after_title'   => '</h2>',
		) );
		register_sidebar( array(
			'name'          => esc_html__( 'FP: One Third 3', 'devwp' ),
			'id'            => 'one-third-3',
			'description'   => esc_html__( 'Add widgets here.', 'devwp' ),
			'before_widget' => '<section id="%1$s" class="widget %2$s">',
			'after_widget'  => '</section>',
			'before_title'  => '<h2 class="widget-title">',
			'after_title'   => '</h2>',
		) );

		register_sidebar( array(
			'name'          => esc_html__( 'Home Page Edge to Edge', 'devwp' ),
			'id'            => 'home-full-edge',
			'description'   => esc_html__( 'This is the Blog Roll Page aka home.php.', 'devwp' ),
			'before_widget' => '<section id="%1$s" class="widget %2$s">',
			'after_widget'  => '</section>',
			'before_title'  => '<h2 class="widget-title">',
			'after_title'   => '</h2>',
		) );

		register_sidebar( array(
			'name'          => esc_html__( 'Below Content', 'devwp' ),
			'id'            => 'below-content',
			'description'   => esc_html__( 'Display Widgets Below your Posts.', 'devwp' ),
			'before_widget' => '<section id="%1$s" class="widget %2$s">',
			'after_widget'  => '</section>',
			'before_title'  => '<h2 class="widget-title">',
			'after_title'   => '</h2>',
		) );

		register_sidebar( array(
			'name'          => esc_html__( 'Footer Left', 'devwp' ),
			'id'            => 'footer-left',
			'description'   => esc_html__( 'Add widgets here.', 'devwp' ),
			'before_widget' => '<section id="%1$s" class="widget %2$s">',
			'after_widget'  => '</section>',
			'before_title'  => '<h2 class="widget-title">',
			'after_title'   => '</h2>',
		) );

		register_sidebar( array(
			'name'          => esc_html__( 'Footer Middle', 'devwp' ),
			'id'            => 'footer-middle',
			'description'   => esc_html__( 'Add widgets here.', 'devwp' ),
			'before_widget' => '<section id="%1$s" class="widget %2$s">',
			'after_widget'  => '</section>',
			'before_title'  => '<h2 class="widget-title">',
			'after_title'   => '</h2>',
		) );

		register_sidebar( array(
			'name'          => esc_html__( 'Footer Right', 'devwp' ),
			'id'            => 'footer-right',
			'description'   => esc_html__( 'Add widgets here.', 'devwp' ),
			'before_widget' => '<section id="%1$s" class="widget %2$s">',
			'after_widget'  => '</section>',
			'before_title'  => '<h2 class="widget-title">',
			'after_title'   => '</h2>',
		) );
	}

	add_action( 'widgets_init', 'devwp_widgets_init' );
