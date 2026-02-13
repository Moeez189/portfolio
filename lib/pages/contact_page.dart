import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../sections/glass_navbar.dart';
import '../sections/gradient_background.dart';
import '../widgets/footer_section.dart';
import '../utils/url_fragment.dart' as url_fragment;

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  final _formKey = GlobalKey<FormState>();

  bool _navFading = false;

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _websiteController = TextEditingController();
  final _messageController = TextEditingController();

  String? _budget;
  String? _hasWebsite;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _websiteController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _fadeOverlayThen(VoidCallback action) async {
    if (_navFading) {
      action();
      return;
    }

    setState(() => _navFading = true);
    await Future.delayed(const Duration(milliseconds: 240));
    if (!mounted) return;
    action();
    await Future.delayed(const Duration(milliseconds: 180));
    if (!mounted) return;
    setState(() => _navFading = false);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 900;

    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Stack(
              children: [
                const Positioned.fill(child: GradientBackground()),
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: isDesktop ? 80 : 24,
                        vertical: 120,
                      ),
                      child: Center(
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 980),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Let's build your website together",
                                style: TextStyle(
                                  fontSize: isDesktop ? 52 : 34,
                                  fontWeight: FontWeight.w700,
                                  height: 1.15,
                                  letterSpacing: -1.2,
                                  color: const Color(0xFF1A1A1A),
                                ),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                "Have a project in mind or just want to say hello? I’d love to hear from you!",
                                style: TextStyle(
                                  fontSize: 16,
                                  height: 1.8,
                                  color: Colors.grey[700],
                                ),
                              ),
                              const SizedBox(height: 32),

                              /// Form Card
                              Container(
                                padding: const EdgeInsets.all(28),
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.85),
                                  borderRadius: BorderRadius.circular(24),
                                  border: Border.all(
                                    color: Colors.grey.withValues(alpha: 0.15),
                                  ),
                                ),
                                child: Form(
                                  key: _formKey,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      _fieldLabel("What's your name?"),
                                      const SizedBox(height: 8),
                                      TextFormField(
                                        controller: _nameController,
                                        decoration: _inputDecoration(),
                                        validator: (v) =>
                                            (v == null || v.trim().isEmpty)
                                            ? 'Required'
                                            : null,
                                      ),
                                      const SizedBox(height: 18),

                                      _fieldLabel('Email'),
                                      const SizedBox(height: 8),
                                      TextFormField(
                                        controller: _emailController,
                                        decoration: _inputDecoration(),
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        validator: (v) =>
                                            (v == null || v.trim().isEmpty)
                                            ? 'Required'
                                            : null,
                                      ),
                                      const SizedBox(height: 18),

                                      _fieldLabel('Budget range'),
                                      const SizedBox(height: 8),
                                      DropdownButtonFormField<String>(
                                        value: _budget,
                                        decoration: _inputDecoration(),
                                        items: const [
                                          DropdownMenuItem(
                                            value: 'Under \$1k',
                                            child: Text('Under \$1k'),
                                          ),
                                          DropdownMenuItem(
                                            value: '\$1k - \$5k',
                                            child: Text('\$1k - \$5k'),
                                          ),
                                          DropdownMenuItem(
                                            value: '\$5k - \$10k',
                                            child: Text('\$5k - \$10k'),
                                          ),
                                          DropdownMenuItem(
                                            value: '\$10k+',
                                            child: Text('\$10k+'),
                                          ),
                                        ],
                                        onChanged: (v) =>
                                            setState(() => _budget = v),
                                      ),
                                      const SizedBox(height: 18),

                                      _fieldLabel(
                                        'Do you have a current website?',
                                      ),
                                      const SizedBox(height: 8),
                                      DropdownButtonFormField<String>(
                                        value: _hasWebsite,
                                        decoration: _inputDecoration(),
                                        items: const [
                                          DropdownMenuItem(
                                            value: 'Yes',
                                            child: Text('Yes'),
                                          ),
                                          DropdownMenuItem(
                                            value: 'No',
                                            child: Text('No'),
                                          ),
                                        ],
                                        onChanged: (v) =>
                                            setState(() => _hasWebsite = v),
                                      ),
                                      const SizedBox(height: 18),

                                      _fieldLabel('How can I help you?'),
                                      const SizedBox(height: 8),
                                      TextFormField(
                                        controller: _messageController,
                                        decoration: _inputDecoration(),
                                        maxLines: 5,
                                      ),
                                      const SizedBox(height: 22),

                                      SizedBox(
                                        height: 44,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            if (!_formKey.currentState!
                                                .validate()) {
                                              return;
                                            }
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: const Color(
                                              0xFF1A1A1A,
                                            ),
                                            foregroundColor: Colors.white,
                                            elevation: 0,
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 18,
                                            ),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                            ),
                                          ),
                                          child: const Text(
                                            'Send',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              const SizedBox(height: 40),
                            ],
                          ),
                        ),
                      ),
                    ),

                    /// Footer
                    const FooterSection(),
                  ],
                ),
              ],
            ),
          ),

          /// Navbar
          GlassNavbar(
            onLogoTap: () => _fadeOverlayThen(() {
              context.go('/');
              url_fragment.setFragment('');
            }),
            onWorkTap: () => _fadeOverlayThen(() {
              context.go('/');
              WidgetsBinding.instance.addPostFrameCallback((_) {
                url_fragment.setFragment('work');
              });
            }),
            onAboutTap: () => _fadeOverlayThen(() => context.go('/about')),
            onServicesTap: () => _fadeOverlayThen(() {
              context.go('/');
              WidgetsBinding.instance.addPostFrameCallback((_) {
                url_fragment.setFragment('services');
              });
            }),
            onContactTap: () => _fadeOverlayThen(() => context.go('/contact')),
            onResumeTap: () {},
          ),

          /// Fade Overlay
          IgnorePointer(
            ignoring: !_navFading,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 180),
              curve: Curves.easeInOut,
              opacity: _navFading ? 1 : 0,
              child: Container(
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _fieldLabel(String label) {
    return Text(
      label,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: Color(0xFF1A1A1A),
      ),
    );
  }

  InputDecoration _inputDecoration() {
    return InputDecoration(
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: Colors.grey.withValues(alpha: 0.25)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Color(0xFF1A1A1A), width: 1),
      ),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
    );
  }
}
