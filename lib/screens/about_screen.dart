import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recharge_snap/colors.dart';
import 'package:recharge_snap/generated/l10n.dart';
import 'package:recharge_snap/widgets/custom_tooltip.dart';

import 'package:recharge_snap/widgets/show_toast.dart';
import 'package:toastification/toastification.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  static const routeName = '/about';

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _scaleAnimation = Tween<double>(
      begin: 0.5,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    _opacityAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutQuad),
    );

    SchedulerBinding.instance.addPostFrameCallback((_) {
      _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _launchUrl(
    String url, {
    required BuildContext context,
    required String platform,
  }) async {
    try {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
      if (!context.mounted) return;
      showToast(
        context: context,
        message: 'redirecting to $platform',
        toastType: ToastificationType.success,
      );
    } catch (_) {
      if (!context.mounted) return;
      showToast(
        context: context,
        message: 'Failed to redirect to $platform',
        toastType: ToastificationType.error,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [primaryColor, secondaryColor],
              begin: beginAlignment,
              end: endAlignment,
            ),
          ),
          child: SafeArea(
            child: Stack(
              children: [
                Center(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 60),
                        AnimatedBuilder(
                          animation: _controller,
                          builder: (context, child) {
                            return Transform.translate(
                              offset: const Offset(0, -20),
                              child: Opacity(
                                opacity: _opacityAnimation.value,
                                child: Transform.scale(
                                  scale: _scaleAnimation.value,
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      CircleAvatar(
                                        radius: 90,
                                        backgroundColor: Colors.white24,
                                      ),
                                      CustomTooltip(
                                        message: S.of(context).elzoz,
                                        backgroundColor: Color.fromARGB(
                                          90,
                                          33,
                                          243,
                                          226,
                                        ),
                                        verticalOffset: -100,
                                        child: SizedBox(
                                          width: 171,
                                          height: 171,
                                          child: ClipOval(
                                            // width: 100,
                                            //  height: 100,

                                            //  radius: 86,
                                            child: CachedNetworkImage(
                                              imageUrl:
                                                  'https://res.cloudinary.com/dbl6rerdz/image/upload/v1750264165/profile_image.jpg',
                                              imageBuilder:
                                                  (
                                                    context,
                                                    imageProvider,
                                                  ) => Container(
                                                    decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                        image: imageProvider,
                                                        fit: BoxFit.cover,
                                                        // You can add colorFilter, alignment, etc. here
                                                      ),
                                                    ),
                                                  ),
                                              placeholder:
                                                  (
                                                    context,
                                                    url,
                                                  ) => const Center(
                                                    child:
                                                        CircularProgressIndicator(
                                                          color: Colors.white,
                                                        ),
                                                  ),
                                              errorWidget:
                                                  (
                                                    context,
                                                    url,
                                                    error,
                                                  ) => Image.asset(
                                                    'assets/images/profile_image.jpg',
                                                  ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 20),
                        SlideTransition(
                          position: _slideAnimation,
                          child: FadeTransition(
                            opacity: _opacityAnimation,
                            child: _GlassMorphicCard(
                              child: Padding(
                                padding: const EdgeInsets.all(24),
                                child: Column(
                                  children: [
                                    //** profile info
                                    Text(
                                      'Ziad Mohamed',
                                      style: GoogleFonts.underdog(
                                        textStyle: const TextStyle(
                                          fontSize: 28,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      'App Devoloper | Flutter Developer',
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.underdog(
                                        textStyle: TextStyle(
                                          fontSize: 16,
                                          color: Colors.grey[400],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    CustomTooltip(
                                      message: 'Phone 📞',
                                      backgroundColor: const Color.fromARGB(
                                        90,
                                        33,
                                        149,
                                        243,
                                      ),
                                      child: _ContactTile(
                                        icon: Icons.phone,
                                        text: '+20 155 408 3601',
                                        onTap:
                                            () => _launchUrl(
                                              'tel:+201554083601',
                                              context: context,
                                              platform: 'phone',
                                            ),
                                      ),
                                    ),
                                    const Divider(color: Colors.white24),
                                    CustomTooltip(
                                      message: 'Send me a mail 📩',
                                      backgroundColor: const Color.fromARGB(
                                        90,
                                        33,
                                        149,
                                        243,
                                      ),
                                      child: _ContactTile(
                                        icon: Icons.email,
                                        text: 'ziadmohshahien5',
                                        onTap:
                                            () => _launchUrl(
                                              'mailto:ziadmohshahien5@gmail.com',
                                              context: context,
                                              platform: 'Email',
                                            ),
                                      ),
                                    ),
                                    const Divider(color: Colors.white24),
                                    CustomTooltip(
                                      message: 'Chat me on WhatsApp 💬',
                                      backgroundColor: const Color.fromARGB(
                                        90,
                                        33,
                                        149,
                                        243,
                                      ),
                                      child: _ContactTile(
                                        icon: FontAwesomeIcons.whatsapp,
                                        text: 'WhatsApp Me',
                                        onTap:
                                            () => _launchUrl(
                                              'https://wa.me/201554083601',
                                              context: context,
                                              platform: 'WhatsApp',
                                            ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        SlideTransition(
                          position: _slideAnimation,
                          child: FadeTransition(
                            opacity: _opacityAnimation,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomTooltip(
                                  message: 'Facebook Account',
                                  backgroundColor: Colors.blue,
                                  child: _SocialButton(
                                    icon: FontAwesomeIcons.facebookF,
                                    iconSize: 28,

                                    onTap:
                                        () => _launchUrl(
                                          'https://www.facebook.com/share/194wftyVh7/',
                                          context: context,
                                          platform: 'Facebook',
                                        ),
                                  ),
                                ),
                                CustomTooltip(
                                  message: 'LinkedIn Account',

                                  backgroundColor: Colors.lightBlue,
                                  child: _SocialButton(
                                    icon: FontAwesomeIcons.linkedinIn,
                                    iconSize: 24,
                                    onTap:
                                        () => _launchUrl(
                                          'https://www.linkedin.com/in/ziad-mohamed-76b8a518b',
                                          context: context,
                                          platform: 'LinkedIn',
                                        ),
                                  ),
                                ),
                                CustomTooltip(
                                  message: 'Instagram Account',

                                  backgroundColor: Colors.redAccent,
                                  child: _SocialButton(
                                    icon: FontAwesomeIcons.instagram,
                                    iconSize: 26,
                                    onTap:
                                        () => _launchUrl(
                                          'https://www.instagram.com/ziad_mohamed_sh0',
                                          context: context,
                                          platform: 'Instagram',
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                //back button
                Positioned(
                  top: 10,
                  left: 10,
                  child: CustomTooltip(
                    message: 'Back ',
                    verticalOffset: 30,
                    backgroundColor: const Color.fromARGB(90, 33, 149, 243),
                    child: _SocialButton(
                      icon: FontAwesomeIcons.arrowLeft,
                      iconSize: 24,
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _GlassMorphicCard extends StatelessWidget {
  const _GlassMorphicCard({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white24),
        boxShadow: const [
          BoxShadow(color: Color(0x1f000000), blurRadius: 16, spreadRadius: 4),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0x19ffffff), Color(0x0Dffffff)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}

class _ContactTile extends StatefulWidget {
  const _ContactTile({
    required this.icon,
    required this.text,
    required this.onTap,
  });

  final IconData icon;
  final String text;
  final VoidCallback onTap;

  @override
  State<_ContactTile> createState() => _ContactTileState();
}

class _ContactTileState extends State<_ContactTile> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: _isHovered ? Colors.white12 : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListTile(
            leading: Icon(widget.icon, color: Colors.white),
            title: Text(
              widget.text,
              style: const TextStyle(color: Colors.white),
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios_rounded,
              color: Color(0xcfffffff),
              size: 16,
            ),
          ),
        ),
      ),
    );
  }
}

class _SocialButton extends StatefulWidget {
  const _SocialButton({
    required this.icon,
    required this.onTap,
    required this.iconSize,
  });

  final IconData icon;
  final double iconSize;
  final VoidCallback onTap;

  @override
  State<_SocialButton> createState() => _SocialButtonState();
}

class _SocialButtonState extends State<_SocialButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) => _controller.reverse(),
      onTapCancel: () => _controller.reverse(),
      onTap: widget.onTap,
      child: ScaleTransition(
        scale: Tween(begin: 1.0, end: 0.9).animate(_controller),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 12),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [
                Color(0x33FFFFFF), // White with 20% opacity (0.2)
                Color(0x1AFFFFFF), // White with 10% opacity (0.1)
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: FaIcon(
              widget.icon,
              color: Colors.white,
              size: widget.iconSize,
            ),
          ),
        ),
      ),
    );
  }
}
