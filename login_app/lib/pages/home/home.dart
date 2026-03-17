import 'package:flutter/material.dart';
import '../../Widgets/appbar.dart';
import '../../Widgets/navigation_drawer.dart';
import '../../Widgets/navigation_bottom.dart';
import '../../services/auth_service.dart';
import '../user/user.dart';
import '../auth/change_password.dart';
import '../auth/login.dart';

class HomeScreen extends StatefulWidget {
  final String username;

  const HomeScreen({
    super.key,
    required this.username,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      HomeContent(username: widget.username, onModuleTap: _onHomeModuleTap),
      UserScreen(username: widget.username),
      const ChangePasswordScreen(),
    ];
  }

  void _onHomeModuleTap(String module) {
    switch (module) {
      case 'perfil':
        setState(() {
          _currentIndex = 1;
        });
        _pageController.jumpToPage(1);
        break;
      case 'configuracion':
        setState(() {
          _currentIndex = 2;
        });
        _pageController.jumpToPage(2);
        break;
      case 'notificaciones':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const NotificationsScreen()),
        );
        break;
      case 'ayuda':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HelpScreen()),
        );
        break;
    }
  }

  void _onDrawerItemSelected(int index) {
    if (index <= 2) {
      setState(() {
        _currentIndex = index;
        _pageController.jumpToPage(index);
      });
      _scaffoldKey.currentState?.closeDrawer();
      return;
    }

    _scaffoldKey.currentState?.closeDrawer();
    final sectionName = switch (index) {
      3 => 'Notificaciones',
      4 => 'Ayuda',
      5 => 'Acerca de',
      _ => 'Seccion',
    };
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$sectionName en construccion')),
    );
  }

  Future<void> _logout() async {
    await AuthService.instance.clearToken();
    if (!mounted) return;

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: CustomAppBar(
        title: _getTitle(),
        showBackButton: false,
        onMenuPressed: () => _scaffoldKey.currentState?.openDrawer(),
      ),
      drawer: CustomDrawer(
        username: widget.username,
        onItemSelected: _onDrawerItemSelected,
        onLogout: _logout,
        currentIndex: _currentIndex,
      ),
      body: PageView(
        controller: _pageController,
        children: _pages,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      bottomNavigationBar: BottomNavigation(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          _pageController.jumpToPage(index);
        },
      ),
    );
  }

  String _getTitle() {
    switch (_currentIndex) {
      case 0:
        return 'Inicio';
      case 1:
        return 'Perfil';
      case 2:
        return 'Configuracion';
      default:
        return 'Mi App';
    }
  }
}

class HomeContent extends StatelessWidget {
  final String username;
  final ValueChanged<String> onModuleTap;

  const HomeContent({
    super.key,
    required this.username,
    required this.onModuleTap,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Bienvenido, $username!',
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          const Card(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Icon(Icons.home, size: 50, color: Colors.blue),
                  SizedBox(height: 10),
                  Text('Esta es la pantalla principal de la aplicacion.'),
                  SizedBox(height: 10),
                  Text(
                    'Usa el menu lateral o la barra de navegacion inferior para explorar las diferentes secciones.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            children: [
              _buildFeatureCard(
                icon: Icons.person,
                title: 'Perfil',
                color: Colors.blue,
                onTap: () => onModuleTap('perfil'),
              ),
              _buildFeatureCard(
                icon: Icons.settings,
                title: 'Configuracion',
                color: Colors.green,
                onTap: () => onModuleTap('configuracion'),
              ),
              _buildFeatureCard(
                icon: Icons.notifications,
                title: 'Notificaciones',
                color: Colors.orange,
                onTap: () => onModuleTap('notificaciones'),
              ),
              _buildFeatureCard(
                icon: Icons.help,
                title: 'Ayuda',
                color: Colors.purple,
                onTap: () => onModuleTap('ayuda'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureCard({
    required IconData icon,
    required String title,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 3,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 40, color: color),
              const SizedBox(height: 10),
              Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(title: 'Notificaciones', showBackButton: true),
      body: Center(child: Text('Modulo de notificaciones')),
    );
  }
}

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(title: 'Ayuda', showBackButton: true),
      body: Center(child: Text('Modulo de ayuda')),
    );
  }
}
