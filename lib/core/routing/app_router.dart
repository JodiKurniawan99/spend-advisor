import 'package:flutter/material.dart';

import '../../features/decision/domain/entities/purchase_decision.dart';
import '../../features/decision/presentation/pages/add_decision_page.dart';
import '../../features/decision/presentation/pages/decision_detail_page.dart';
import '../../features/decision/presentation/pages/home_page.dart';

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const HomePage());
      case '/add':
        return MaterialPageRoute(builder: (_) => const AddDecisionPage());
      case '/detail':
        final decision = settings.arguments! as PurchaseDecision;
        return MaterialPageRoute(
          builder: (_) => DecisionDetailPage(decision: decision),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(body: Center(child: Text('Page not found'))),
        );
    }
  }
}
