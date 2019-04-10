<?php
	/**
	 * DevWP: Customizer
	 *
	 * @package DevWP
	 * @since 1.0.0
	 */
	/**
	 * There are four parts to the Customizer:
	 * Panels
	 * Sections
	 * Settings
	 * Controls
	 *
	 * There are 3 Hooks to work with:
	 * customize_register        - REQUIRED
	 * wp_head                   - REQUIRED
	 * customize_preview_init    - OPTIONAL
	 */
	/**
	 * Add postMessage support for site title and description for the Theme Customizer.
	 *
	 * @param WP_Customize_Manager $wp_customize Theme Customizer object.
	 */
	
	
	function devwp_customize_register( $wp_customize ) {
		$wp_customize->get_setting( 'blogname' )->transport        = 'postMessage';
		$wp_customize->get_setting( 'blogdescription' )->transport = 'postMessage';
		$wp_customize->get_section( 'header_image' )->panel        = 'dev_header_panel';
		
		// Remove the Background Image and Color. In a future update, I will add Color Schemes
		$wp_customize->remove_section( 'background_image' );
		$wp_customize->remove_control( 'background_color' );
		$wp_customize->remove_control( 'header_textcolor' );
		
		if ( isset( $wp_customize->selective_refresh ) ) {
			$wp_customize->selective_refresh->add_partial( 'blogname', array(
				'selector'        => '.site-title a',
				'render_callback' => 'devwp_customize_partial_blogname',
			) );
			$wp_customize->selective_refresh->add_partial( 'blogdescription', array(
				'selector'        => '.site-description',
				'render_callback' => 'devwp_customize_partial_blogdescription',
			) );
		}
		
		// Theme links
		class DevWP_Links extends WP_Customize_Control {
			public $type = "devwp-links";
			
			public function render_content() {
				$devwp_links = array(
					'view-themes' => array(
						'link' => esc_url( 'https://www.pixemweb.com/premium-wordpress-themes/' ),
						'text' => esc_html__( 'Checkout Some Themes', 'devwp' ),
					),
					'demo'        => array(
						'link' => esc_url( 'https://www.pixemweb.com/devwp/' ),
						'text' => esc_html__( 'View DevWP Demo &amp; Docs', 'devwp' ),
					),
					'video'       => array(
						'link' => esc_url( 'https://youtu.be/pEJ2IzYOx5c' ),
						'text' => esc_html__( 'Video Documentation', 'devwp' ),
					),
					'subscribe'   => array(
						'link' => esc_url( 'https://www.youtube.com/c/Pixemweb?sub_confirmation=1' ),
						'text' => esc_html__( 'Subscribe on YouTube', 'devwp' ),
					),
					'support'     => array(
						'link' => esc_url( 'https://www.pixemweb.com/contact-us/' ),
						'text' => esc_html__( 'Support', 'devwp' ),
					),
				);
				
				foreach ( $devwp_links as $devwp_link ) {
					echo '<p><a target="_blank" href="' . $devwp_link[ 'link' ] . '" >' . esc_attr( $devwp_link[ 'text' ] ) . ' </a></p>';
				}
			}
		}
		
		$wp_customize->add_section( 'devwp_links', array(
			'priority' => 1,
			'title'    => esc_html__( 'DevWP Links &amp; Support ', 'devwp' ),
		) );
		
		/**
		 * Sanitization Placeholder.
		 */
		function devwp_false_sanitize() {
			return false;
		}
		
		$wp_customize->add_setting( 'devwp_links', array(
			'capability'        => 'edit_theme_options',
			'sanitize_callback' => 'devwp_false_sanitize'
		) );
		
		$wp_customize->add_control( new DevWP_Links( $wp_customize, 'devwp_links', array(
			'section'  => 'devwp_links',
			'settings' => 'devwp_links'
		) ) );
		
		
		//___Header area___//
		$wp_customize->add_panel( 'dev_header_panel', array(
			'priority'       => 10,
			'title'          => esc_html__( 'Header Area', 'devwp' ),
		) );
	
		//___Header Text___//
		$wp_customize->add_section(
			'devwp_header_text',
			array(
				'title'    => esc_html__( 'Header Text', 'devwp' ),
				'priority' => 100,
				'capability' => 'edit_theme_options',
				'panel'    => 'dev_header_panel',
			)
		);
		
		$wp_customize->add_setting(
			'header_subtext',
			array(
				'default'           => '',
				'capability'        => 'edit_theme_options',
				'sanitize_callback' => 'devwp_sanitize_text',
				'transport'         => 'postMessage',
			)
		);
		$wp_customize->add_control(
			'header_subtext',
			array(
				'label'    => esc_html__( 'FP: Top Text', 'devwp' ),
				'description'   => esc_html__('Smaller Header Text', 'devwp'),
				'section'  => 'devwp_header_text',
				'type'     => 'text',
				'priority' => 10
			)
		);
		
		$wp_customize->add_setting(
			'header_text',
			array(
				'default'           => '',
				'capability'        => 'edit_theme_options',
				'sanitize_callback' => 'devwp_sanitize_text',
				'transport'         => 'postMessage'
			)
		);
		$wp_customize->add_control(
			'header_text',
			array(
				'label'    => esc_html__( 'FP: Bottom Text', 'devwp' ),
				'description'   => esc_html__('Larger Header Text', 'devwp'),
				'section'  => 'devwp_header_text',
				'type'     => 'text',
				'priority' => 10
			)
		);

		$wp_customize->add_setting(
			'header_button',
			array(
				'default'           => '',
				'capability'        => 'edit_theme_options',
				'sanitize_callback' => 'devwp_sanitize_text',
			)
		);
		$wp_customize->add_control(
			'header_button',
			array(
				'label'    => esc_html__( 'FP: Button Text', 'devwp' ),
				'description'   => esc_html__('Button Call to Action Text', 'devwp'),
				'section'  => 'devwp_header_text',
				'type'     => 'text',
				'priority' => 10
			)
		);
		$wp_customize->add_setting(
			'header_button_url',
			array(
				'default'           => '',
				'capability'        => 'edit_theme_options',
				'sanitize_callback' => 'esc_url_raw',
			)
		);
		$wp_customize->add_control(
			'header_button_url',
			array(
				'label'    => esc_html__( 'FP: Button URL', 'devwp' ),
				'description'   => esc_html__('Destination URL', 'devwp'),
				'section'  => 'devwp_header_text',
				'type'     => 'text',
				'priority' => 11
			)
		);
		
		$wp_customize->add_setting(
			'header_blog_secondary_text',
			array(
				'default'           => '',
				'capability'        => 'edit_theme_options',
				'sanitize_callback' => 'devwp_sanitize_text',
				'transport'         => 'postMessage'
			)
		);
		$wp_customize->add_control(
			'header_blog_secondary_text',
			array(
				'label'    => esc_html__( 'BP: Top Text', 'devwp' ),
				'description'   => esc_html__('Smaller Header Text', 'devwp'),
				'section'  => 'devwp_header_text',
				'type'     => 'text',
				'priority' => 13
			)
		);
		$wp_customize->add_setting(
			'header_blog',
			array(
				'default'           => '',
				'capability'        => 'edit_theme_options',
				'sanitize_callback' => 'devwp_sanitize_text',
				'transport'         => 'postMessage'
			)
		);
		$wp_customize->add_control(
			'header_blog',
			array(
				'label'    => esc_html__( 'BP: Bottom Text', 'devwp' ),
				'description'   => esc_html__('Add Your Larger Header Text', 'devwp'),
				'section'  => 'devwp_header_text',
				'type'     => 'text',
				'priority' => 12
			)
		);
		
		
		$wp_customize->add_setting(
			'header_blog_button',
			array(
				'default'           => '',
				'capability'        => 'edit_theme_options',
				'sanitize_callback' => 'devwp_sanitize_text',
			)
		);
		$wp_customize->add_control(
			'header_blog_button',
			array(
				'label'    => esc_html__( 'BP: Button Text', 'devwp' ),
				'description'   => esc_html__('Button Call to Action Text', 'devwp'),
				'section'  => 'devwp_header_text',
				'type'     => 'text',
				'priority' => 15
			)
		);
		$wp_customize->add_setting(
			'header_blog_button_url',
			array(
				'default'           => '',
				'capability'        => 'edit_theme_options',
				'sanitize_callback' => 'esc_url_raw',
			)
		);
		$wp_customize->add_control(
			'header_blog_button_url',
			array(
				'label'    => esc_html__( 'BP: Button URL', 'devwp' ),
				'description'   => esc_html__('Destination URL', 'devwp'),
				'section'  => 'devwp_header_text',
				'type'     => 'text',
				'priority' => 16
			)
		);
		
		//___Theme options___//
		$wp_customize->add_section(
			'devwp_theme_options',
			array(
				'title'      => esc_html__( 'Theme Options', 'devwp' ),
				'capability' => 'edit_theme_options',
				'priority'   => 13,
			)
		);
		
		//select sanitization function
		function devwp_sanitize_select( $input, $setting ) {
			
			//input must be a slug: lowercase alphanumeric characters, dashes and underscores are allowed only
			$input = sanitize_key( $input );
			
			//get the list of possible select options
			$choices = $setting->manager->get_control( $setting->id )->choices;
			
			//return input if valid or return default option
			return ( array_key_exists( $input, $choices ) ? $input : $setting->default );
			
		}
		
		$wp_customize->add_setting( 'devwp_container_type', array(
			'default'           => 'container',
			'capability'        => 'edit_theme_options',
			'type'              => 'theme_mod',
			'sanitize_callback' => 'devwp_sanitize_select',
		) );
		
		$wp_customize->add_control(
			new WP_Customize_Control(
				$wp_customize,
				'devwp_container_type', array(
					'label'       => esc_html__( 'Container Width', 'devwp' ),
					'description' => esc_html__( "Choose between Bootstrap's Container and Container-Fluid", 'devwp' ),
					'section'     => 'devwp_theme_options',
					'settings'    => 'devwp_container_type',
					'type'        => 'select',
					'choices'     => array(
						'container'       => esc_html__( 'Centered Width Container', 'devwp' ),
						'container-fluid' => esc_html__( 'Fluid Edge Width Container', 'devwp' ),
					),
					'priority'    => '10',
				)
			) );
		
		$wp_customize->add_setting( 'devwp_navbar_type', array(
			'default'           => 'standard-navbar',
			'capability'        => 'edit_theme_options',
			'type'              => 'theme_mod',
			'sanitize_callback' => 'devwp_sanitize_select',
		) );
		
		$wp_customize->add_control(
			new WP_Customize_Control(
				$wp_customize,
				'devwp_navbar_type', array(
					'label'       => esc_html__( 'Navbar Type', 'devwp' ),
					'description' => esc_html__( "Choose between a Standard Navbar and Fixed Navbar", 'devwp' ),
					'section'     => 'devwp_theme_options',
					'settings'    => 'devwp_navbar_type',
					'type'        => 'select',
					'choices'     => array(
						'standard-navbar' => esc_html__( 'Standard Navbar', 'devwp' ),
						'fixed-top'       => esc_html__( 'Fixed Navbar', 'devwp' ),
						'offcanvas'       => esc_html__( 'Off Canvas Navbar', 'devwp' ),
					),
					'priority'    => '10',
				)
			) );
		
		$wp_customize->add_setting( 'devwp_sidebar_options', array(
			'default'           => 'right',
			'capability'        => 'edit_theme_options',
			'type'              => 'theme_mod',
			'sanitize_callback' => 'sanitize_text_field',
		) );
		
		$wp_customize->add_control(
			new WP_Customize_Control(
				$wp_customize,
				'devwp_sidebar_options', array(
					'label'             => esc_html__( 'Sidebar Positioning', 'devwp' ),
					'description'       => esc_html__( "Set sidebar's default position. Can either be: right, left or none. Note: this can be overridden on individual posts or pages.",
						'devwp' ),
					'section'           => 'devwp_theme_options',
					'settings'          => 'devwp_sidebar_options',
					'type'              => 'select',
					'sanitize_callback' => 'devwp_sanitize_select',
					'choices'           => array(
						'right' => esc_html__( 'Right Sidebar', 'devwp' ),
						'left'  => esc_html__( 'Left Sidebar', 'devwp' ),
						'none'  => esc_html__( 'No Sidebar', 'devwp' ),
					),
					'priority'          => '13',
				)
			) );
		
		//Excerpt Length
		$wp_customize->add_setting(
			'exc_length',
			array(
				'default'           => '40',
				'capability'        => 'edit_theme_options',
				'sanitize_callback' => 'absint',
			)
		);
		
		$wp_customize->add_control( 'exc_length', array(
			'type'        => 'number',
			'priority'    => 20,
			'section'     => 'devwp_theme_options',
			'label'       => esc_html__( 'Excerpt length', 'devwp' ),
			'description' => esc_html__( "Set a Custom Excerpt Length. Min 10 &amp; Max 200.", 'devwp'),
			'input_attrs' => array(
				'min'  => 10,
				'max'  => 200,
				'step' => 5,
			),
		) );
		
		// Sanitization
		//Text
		function devwp_sanitize_text( $input ) {
			return wp_kses_post( force_balance_tags( $input ) );
		}
	}
	
	add_action( 'customize_register', 'devwp_customize_register' );
	
	/**
	 * Render the site title for the selective refresh partial.
	 *
	 * @return void
	 */
	function devwp_customize_partial_blogname() {
		bloginfo( 'name' );
	}
	
	/**
	 * Render the site tagline for the selective refresh partial.
	 *
	 * @return void
	 */
	function devwp_customize_partial_blogdescription() {
		bloginfo( 'description' );
	}
	
	/**
	 * Binds JS handlers to make Theme Customizer preview reload changes asynchronously.
	 */
	function devwp_customize_preview_js() {
		
		// wp_enqueue_script( 'devwp-customizer', get_template_directory_uri() . '/dist/js/customizer.js', array( 'customize-preview' ), '20151215', true );
		
		// https://developer.wordpress.org/reference/functions/get_theme_file_uri/
		// https://make.wordpress.org/core/2016/09/09/new-functions-hooks-and-behaviour-for-theme-developers-in-wordpress-4-7/
		wp_enqueue_script( 'devwp-customizer', get_theme_file_uri( '/dist/js/customizer.js' ), array( 'customize-preview' ), '1.0.5', true );
		
	}
	
	add_action( 'customize_preview_init', 'devwp_customize_preview_js' );
	
	/*
	* Custom Scripts
	*/
	add_action( 'customize_controls_print_footer_scripts', 'devwp_customizer_custom_scripts' );
	
	function devwp_customizer_custom_scripts() {
		?>
		<style>
			/* Theme Instructions Panel CSS */
			
			li#accordion-section-devwp_links h3.accordion-section-title,
			li#accordion-section-devwp_links h3.accordion-section-title:focus {
				background-color : #CF000F !important;
				color            : #fff !important;
				}
			li#accordion-section-devwp_links h3.accordion-section-title:hover {
				background-color : #F22613 !important;
				color            : #fff !important;
				}
			li#accordion-section-devwp_links h3.accordion-section-title:after {
				color : #fff !important;
				}
			.customize-control-devwp-links a {
				background  : #CF000F;
				color       : #fff;
				display     : block;
				margin      : 15px 0 0;
				padding     : 5px 0;
				text-align  : center;
				font-weight : 600;
				}
			.customize-control-devwp-links a {
				padding : 8px 0;
				}
			.devwp-pro-info:hover,
			.customize-control-devwp-links a:hover {
				color      : #ffffff;
				background : #F22613;
				}
		</style>
		<?php
	}