USE `ovrride`;
UPDATE wp_posts SET guid = replace(guid, 'http://ovrride.com', 'http://ovrride.dev');
UPDATE wp_posts SET guid = replace(guid, 'https://ovrride.com', 'https://ovrride.dev');

UPDATE wp_posts SET post_content = replace(post_content, 'http://ovrride.com', 'http://ovrride.dev');
UPDATE wp_posts SET post_content = replace(post_content, 'https://ovrride.com', 'https://ovrride.dev');

UPDATE wp_postmeta SET meta_value = replace(meta_value,'http://ovrride.com', 'http://ovrride.dev');
UPDATE wp_postmeta SET meta_value = replace(meta_value,'https://ovrride.com', 'https://ovrride.dev');

UPDATE wp_options SET option_value = replace(option_value, 'http://ovrride.com', 'http://ovrride.dev') WHERE option_name = 'home' OR option_name = 'siteurl' OR option_name = 'dashboard_widget_options';
UPDATE wp_options SET option_value = replace(option_value, 'https://ovrride.com', 'https://ovrride.dev') WHERE option_name = 'home' OR option_name = 'siteurl' OR option_name = 'dashboard_widget_options';

/* Remove Spark Post from active plugins, throws a lot of errors when key is unset */
UPDATE wp_options SET option_value='a:36:{i:0;s:29:"gravityforms/gravityforms.php";i:1;s:17:"WP-API/plugin.php";i:2;s:30:"advanced-custom-fields/acf.php";i:3;s:19:"akismet/akismet.php";i:4;s:29:"bj-lazy-load/bj-lazy-load.php";i:5;s:21:"calendar/calendar.php";i:6;s:45:"ewww-image-optimizer/ewww-image-optimizer.php";i:7;s:50:"gravity-forms-constant-contact/constantcontact.php";i:8;s:33:"instagram-feed/instagram-feed.php";i:9;s:31:"master-slider/master-slider.php";i:10;s:39:"mini-twitter-feed/mini-twitter-feed.php";i:11;s:45:"no-captcha-recaptcha/no-captcha-recaptcha.php";i:12;s:41:"ovr-contact-widget/ovr-contact-widget.php";i:13;s:51:"ovr-email-signup-widget/ovr-email-signup-widget.php";i:14;s:31:"ovr_functions/ovr_functions.php";i:15;s:33:"post-expirator/post-expirator.php";i:16;s:25:"quickshare/quickshare.php";i:17;s:47:"really-simple-captcha/really-simple-captcha.php";i:18;s:37:"recent-posts-widget-extended/rpwe.php";i:19;s:49:"responsive-select-menu/responsive-select-menu.php";i:20;s:25:"shortcode-maker/index.php";i:21;s:25:"simple-tooltips/index.php";i:22;s:70:"squelch-tabs-and-accordions-shortcodes/squelch-tabs-and-accordions.php";i:23;s:57:"ssl-insecure-content-fixer/ssl-insecure-content-fixer.php";i:24;s:33:"w3-total-cache/w3-total-cache.php";i:25;s:25:"widget-shortcode/init.php";i:26;s:41:"woocommerce-colors/woocommerce-colors.php";i:27;s:67:"woocommerce-customer-note-email/woocommerce-customer-note-email.php";i:28;s:65:"woocommerce-gateway-paypal-pro/woocommerce-gateway-paypal-pro.php";i:29;s:71:"woocommerce-gravityforms-product-addons/gravityforms-product-addons.php";i:30;s:42:"woocommerce-remove-quantity-text/index.php";i:31;s:55:"woocommerce-smart-coupons/woocommerce-smart-coupons.php";i:32;s:39:"woocommerce-trips/woocommerce-trips.php";i:33;s:27:"woocommerce/woocommerce.php";i:34;s:39:"woothemes-updater/woothemes-updater.php";i:35;s:30:"wordpress-wiki-plugin/wiki.php";}' WHERE option_name='active_plugins' LIMIT 1;
/* Remove API KEY From SP Settings */
UPDATE wp_options SET option_value = ' a:5:{s:10:"from_email";s:16:"info@ovrride.com";s:9:"from_name";s:7:"OvRride";s:16:"enable_sparkpost";b:0;s:14:"sending_method";s:3:"api";s:15:"enable_tracking";b:1;'WHERE option_name = 'sp_settings' LIMIT 1;


#UPDATE mysql.user SET Host = '%' WHERE User = 'dev' AND Host = 'localhost';
#DELETE From mysql.user WHERE User = 'dev' AND Host <> '%';
#FLUSH PRIVILEGES;
