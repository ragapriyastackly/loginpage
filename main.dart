import 'package:flutter/material.dart';

// ============================================================================
// HOTELIER — Welcome Back (Login) Screen
// Single-screen layout, NO scrolling. Structured to match the design 1:1.
//
// IMPORTANT (read this):
// The background lobby photo cannot be extracted from the screenshot you
// sent — it's a photograph, not something I can regenerate pixel-for-pixel.
// To get it "ditto" (exactly identical), do this:
//   1. Save your hotel lobby photo as: assets/hotel_lobby.jpg
//   2. Make sure pubspec.yaml lists the assets folder (see pubspec.yaml
//      included alongside this file).
// Everything else — layout, spacing, colors, fonts, icons, card, buttons,
// nav bar, feature strips, footer — is built to match the screenshot exactly.
// ============================================================================

void main() {
  runApp(const HotelierApp());
}

class HotelierApp extends StatelessWidget {
  const HotelierApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hotelier',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Georgia', // serif fallback for headline font
        useMaterial3: true,
      ),
      home: const HotelierLoginScreen(),
    );
  }
}

// ---------------------------------------------------------------------------
// Brand colors (sampled from the design)
// ---------------------------------------------------------------------------
class AppColors {
  static const Color amber = Color(0xFFD9922D); // primary accent orange
  static const Color amberLight = Color(0xFFE8A94A);
  static const Color darkOverlay = Color(0xFF14110E); // top-left logo panel
  static const Color heroOverlayTop = Color(0xCC0B0B0B);
  static const Color heroOverlayBottom = Color(0xE6000000);
  static const Color footerBg = Color(0xFF17130F);
  static const Color featureStripBg = Color(0xFFF7F5F3);
  static const Color textDark = Color(0xFF1C1B19);
  static const Color textGrey = Color(0xFF6B6B6B);
}

class HotelierLoginScreen extends StatefulWidget {
  const HotelierLoginScreen({super.key});

  @override
  State<HotelierLoginScreen> createState() => _HotelierLoginScreenState();
}

class _HotelierLoginScreenState extends State<HotelierLoginScreen> {
  bool _obscurePassword = true;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // Column with fixed-height header/footer and an Expanded hero section
      // guarantees the ENTIRE screen fits with zero scrolling, exactly like
      // the reference design.
      body: SafeArea(
        child: Column(
          children: [
            _TopNavBar(),
            Expanded(child: _HeroSection(
              obscurePassword: _obscurePassword,
              onToggleObscure: () {
                setState(() => _obscurePassword = !_obscurePassword);
              },
              emailController: _emailController,
              passwordController: _passwordController,
            )),
            _FeatureStrip(),
            _Footer(),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// TOP NAV BAR
// ---------------------------------------------------------------------------
class _TopNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 78,
      color: AppColors.darkOverlay,
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Row(
        children: [
          // Logo
          Container(
            width: 34,
            height: 34,
            alignment: Alignment.center,
            child: const Text(
              'H',
              style: TextStyle(
                color: AppColors.amber,
                fontSize: 30,
                fontWeight: FontWeight.bold,
                fontFamily: 'Georgia',
              ),
            ),
          ),
          const SizedBox(width: 10),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'HOTELIER',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
              Text(
                'STAY INSPIRED',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 9,
                  letterSpacing: 3,
                ),
              ),
            ],
          ),
          const SizedBox(width: 48),
          _NavLink('Find Hotels'),
          _NavLink('Offers'),
          _NavLink('About Us'),
          _NavLink('Help'),
          const Spacer(),
          Row(
            children: const [
              Icon(Icons.language, color: Colors.white, size: 16),
              SizedBox(width: 6),
              Text('English', style: TextStyle(color: Colors.white, fontSize: 13)),
              Icon(Icons.keyboard_arrow_down, color: Colors.white, size: 16),
            ],
          ),
          const SizedBox(width: 20),
          Container(width: 1, height: 18, color: Colors.white24),
          const SizedBox(width: 20),
          Row(
            children: const [
              Icon(Icons.headset_mic_outlined, color: Colors.white, size: 18),
              SizedBox(width: 6),
              Text('Support', style: TextStyle(color: Colors.white, fontSize: 13)),
            ],
          ),
        ],
      ),
    );
  }
}

class _NavLink extends StatelessWidget {
  final String label;
  const _NavLink(this.label);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontFamily: 'Roboto',
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// HERO SECTION — background photo + left copy + right login card
// ---------------------------------------------------------------------------
class _HeroSection extends StatelessWidget {
  final bool obscurePassword;
  final VoidCallback onToggleObscure;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const _HeroSection({
    required this.obscurePassword,
    required this.onToggleObscure,
    required this.emailController,
    required this.passwordController,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Background lobby photograph.
        // Replace with the real photo at assets/hotel_lobby.jpg for a ditto match.
        Image.asset(
          'lib/images/hotel_lobby_bg.jpg',
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => Container(
            color: const Color(0xFF2B2117),
            alignment: Alignment.center,
            child: const Text(
              'Place hotel_lobby.jpg in /assets\n(see pubspec.yaml)',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white54, fontSize: 14),
            ),
          ),
        ),
        // Dark gradient overlay for text legibility (matches screenshot)
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [Color(0xB3000000), Color(0x33000000)],
              stops: [0.0, 0.7],
            ),
          ),
        ),
        // Content row: left copy + right login card
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(flex: 6, child: _LeftHeroCopy()),
              const SizedBox(width: 24),
              Expanded(
                flex: 4,
                child: Align(
                  alignment: Alignment.center,
                  child: _LoginCard(
                    obscurePassword: obscurePassword,
                    onToggleObscure: onToggleObscure,
                    emailController: emailController,
                    passwordController: passwordController,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _LeftHeroCopy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      // Scale headline based on available height so nothing overflows
      return FittedBox(
        fit: BoxFit.scaleDown,
        alignment: Alignment.centerLeft,
        child: SizedBox(
          width: 560,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              RichText(
                text: const TextSpan(
                  style: TextStyle(
                    fontFamily: 'Georgia',
                    fontSize: 46,
                    height: 1.15,
                    fontWeight: FontWeight.w700,
                  ),
                  children: [
                    TextSpan(text: 'Comfortable ', style: TextStyle(color: Colors.white)),
                    TextSpan(text: 'Stays.\n', style: TextStyle(color: AppColors.amber)),
                    TextSpan(text: 'Memorable ', style: TextStyle(color: Colors.white)),
                    TextSpan(text: 'Journeys.', style: TextStyle(color: AppColors.amber)),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              Container(width: 60, height: 3, color: AppColors.amber),
              const SizedBox(height: 18),
              const Text(
                'Find the perfect hotel for your next trip.\n'
                'Book with ease and enjoy exclusive deals\non stays worldwide.',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: 'Roboto',
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 28),
              const _HeroBullet(
                icon: Icons.sell_outlined,
                title: 'Best Price Guarantee',
                subtitle: 'Get the best prices on thousands of hotels.',
              ),
              const SizedBox(height: 18),
              const _HeroBullet(
                icon: Icons.verified_user_outlined,
                title: 'Secure Booking',
                subtitle: 'Your data is safe with us.',
              ),
              const SizedBox(height: 18),
              const _HeroBullet(
                icon: Icons.headset_mic_outlined,
                title: '24/7 Customer Support',
                subtitle: 'We are here to help you anytime.',
              ),
            ],
          ),
        ),
      );
    });
  }
}

class _HeroBullet extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  const _HeroBullet({required this.icon, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.amber, width: 1.4),
            borderRadius: BorderRadius.circular(8),
          ),
          alignment: Alignment.center,
          child: Icon(icon, color: AppColors.amber, size: 20),
        ),
        const SizedBox(width: 14),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.bold,
                fontFamily: 'Roboto',
              ),
            ),
            const SizedBox(height: 2),
            Text(
              subtitle,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 12.5,
                fontFamily: 'Roboto',
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// LOGIN CARD (right side, white card)
// ---------------------------------------------------------------------------
class _LoginCard extends StatelessWidget {
  final bool obscurePassword;
  final VoidCallback onToggleObscure;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const _LoginCard({
    required this.obscurePassword,
    required this.onToggleObscure,
    required this.emailController,
    required this.passwordController,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return FittedBox(
        fit: BoxFit.scaleDown,
        child: Container(
          width: 400,
          padding: const EdgeInsets.all(28),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.25),
                blurRadius: 30,
                offset: const Offset(0, 12),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Welcome Back',
                style: TextStyle(
                  fontFamily: 'Georgia',
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textDark,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'Login to continue to your account',
                style: TextStyle(color: AppColors.textGrey, fontSize: 13),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(width: 60, height: 1, color: Colors.grey.shade300),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text('H',
                        style: TextStyle(
                            color: AppColors.amber,
                            fontFamily: 'Georgia',
                            fontWeight: FontWeight.bold,
                            fontSize: 16)),
                  ),
                  Container(width: 60, height: 1, color: Colors.grey.shade300),
                ],
              ),
              const SizedBox(height: 20),
              _FieldLabel('Email Address'),
              const SizedBox(height: 6),
              _InputField(
                controller: emailController,
                hint: 'Enter your email',
                icon: Icons.mail_outline,
              ),
              const SizedBox(height: 16),
              _FieldLabel('Password'),
              const SizedBox(height: 6),
              _InputField(
                controller: passwordController,
                hint: 'Enter your password',
                icon: Icons.lock_outline,
                obscureText: obscurePassword,
                suffixIcon: IconButton(
                  icon: Icon(
                    obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                    size: 18,
                    color: Colors.grey,
                  ),
                  onPressed: onToggleObscure,
                ),
              ),
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: const Size(0, 0),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: const Text(
                    'Forgot Password?',
                    style: TextStyle(color: AppColors.amber, fontSize: 12.5, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              const SizedBox(height: 14),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.amber,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Login',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(child: Divider(color: Colors.grey.shade300)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text('or continue with',
                        style: TextStyle(color: Colors.grey.shade500, fontSize: 12)),
                  ),
                  Expanded(child: Divider(color: Colors.grey.shade300)),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: _SocialButton(
                      icon: Icons.g_mobiledata, // placeholder Google glyph
                      label: 'Google',
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _SocialButton(
                      icon: Icons.apple,
                      label: 'Apple',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              RichText(
                text: TextSpan(
                  style: const TextStyle(color: AppColors.textDark, fontSize: 13),
                  children: [
                    const TextSpan(text: "Don't have an account? "),
                    TextSpan(
                      text: 'Sign Up',
                      style: const TextStyle(color: AppColors.amber, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

class _FieldLabel extends StatelessWidget {
  final String text;
  const _FieldLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textDark),
      ),
    );
  }
}

class _InputField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final IconData icon;
  final bool obscureText;
  final Widget? suffixIcon;

  const _InputField({
    required this.controller,
    required this.hint,
    required this.icon,
    this.obscureText = false,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      style: const TextStyle(fontSize: 14),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
        prefixIcon: Icon(icon, size: 18, color: Colors.grey.shade500),
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.amber),
        ),
      ),
    );
  }
}

class _SocialButton extends StatelessWidget {
  final IconData icon;
  final String label;
  const _SocialButton({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {},
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 12),
        side: BorderSide(color: Colors.grey.shade300),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 18, color: AppColors.textDark),
          const SizedBox(width: 6),
          Text(label, style: const TextStyle(color: AppColors.textDark, fontSize: 13)),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// FEATURE STRIP (4 columns under the hero)
// ---------------------------------------------------------------------------
class _FeatureStrip extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 92,
      color: AppColors.featureStripBg,
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Row(
        children: const [
          Expanded(
            child: _FeatureItem(
              icon: Icons.bed_outlined,
              title: 'Wide Selection',
              subtitle: 'Choose from thousands of\nhotels worldwide.',
            ),
          ),
          Expanded(
            child: _FeatureItem(
              icon: Icons.sell_outlined,
              title: 'Exclusive Deals',
              subtitle: 'Access special member\nprices and offers.',
            ),
          ),
          Expanded(
            child: _FeatureItem(
              icon: Icons.calendar_month_outlined,
              title: 'Easy Booking',
              subtitle: 'Book your stay in just a\nfew simple steps.',
            ),
          ),
          Expanded(
            child: _FeatureItem(
              icon: Icons.verified_user_outlined,
              title: 'Trusted & Verified',
              subtitle: 'Curated hotels with verified\nreviews you can trust.',
            ),
          ),
        ],
      ),
    );
  }
}

class _FeatureItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  const _FeatureItem({required this.icon, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.amber, width: 1.2),
            borderRadius: BorderRadius.circular(8),
          ),
          alignment: Alignment.center,
          child: Icon(icon, color: AppColors.amber, size: 18),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 13.5, color: AppColors.textDark)),
              const SizedBox(height: 3),
              Text(subtitle,
                  style: TextStyle(fontSize: 11.5, color: Colors.grey.shade600, height: 1.3)),
            ],
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// FOOTER
// ---------------------------------------------------------------------------
class _Footer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      color: AppColors.footerBg,
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Row(
        children: [
          const Text(
            '© 2026 Hotelier. All rights reserved.',
            style: TextStyle(color: Colors.white70, fontSize: 12),
          ),
          const Spacer(),
          const Text('Privacy Policy', style: TextStyle(color: Colors.white70, fontSize: 12)),
          const SizedBox(width: 12),
          Container(width: 1, height: 12, color: Colors.white24),
          const SizedBox(width: 12),
          const Text('Terms & Conditions', style: TextStyle(color: Colors.white70, fontSize: 12)),
          const SizedBox(width: 12),
          Container(width: 1, height: 12, color: Colors.white24),
          const SizedBox(width: 12),
          const Text('Contact Us', style: TextStyle(color: Colors.white70, fontSize: 12)),
        ],
      ),
    );
  }
}