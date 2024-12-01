import 'package:get/get.dart';

import '../modules/admin/addCategory/bindings/add_category_binding.dart';
import '../modules/admin/addCategory/views/add_category_view.dart';
import '../modules/admin/add_product/bindings/add_product_binding.dart';
import '../modules/admin/add_product/views/add_product_view.dart';
import '../modules/admin/admin_main_page/bindings/admin_main_page_binding.dart';
import '../modules/admin/admin_main_page/views/admin_main_page_view.dart';
import '../modules/admin/bindings/admin_binding.dart';
import '../modules/admin/customers/bindings/customers_binding.dart';
import '../modules/admin/customers/customer_details/bindings/customer_details_binding.dart';
import '../modules/admin/customers/customer_details/views/customer_details_view.dart';
import '../modules/admin/customers/views/customers_view.dart';
import '../modules/admin/dashboard/bindings/dashboard_binding.dart';
import '../modules/admin/dashboard/views/dashboard_view.dart';
import '../modules/admin/edit_product/bindings/edit_product_binding.dart';
import '../modules/admin/edit_product/views/edit_product_view.dart';
import '../modules/admin/financial/bindings/financial_binding.dart';
import '../modules/admin/financial/views/financial_view.dart';
import '../modules/admin/recent_orders/all_orders/bindings/all_orders_binding.dart';
import '../modules/admin/recent_orders/all_orders/views/all_orders_view.dart';
import '../modules/admin/recent_orders/bindings/recent_orders_binding.dart';
import '../modules/admin/recent_orders/order_info/bindings/order_info_binding.dart';
import '../modules/admin/recent_orders/order_info/views/order_info_view.dart';
import '../modules/admin/recent_orders/views/recent_orders_view.dart';
import '../modules/admin/sales_summary/bindings/sales_summary_binding.dart';
import '../modules/admin/sales_summary/views/sales_summary_view.dart';
import '../modules/admin/stocks/bindings/stocks_binding.dart';
import '../modules/admin/stocks/stock_details/bindings/stock_details_binding.dart';
import '../modules/admin/stocks/stock_details/views/stock_details_view.dart';
import '../modules/admin/stocks/views/stocks_view.dart';
import '../modules/admin/views/admin_view.dart';
import '../modules/cart/bindings/cart_binding.dart';
import '../modules/cart/views/cart_view.dart';
import '../modules/category/bindings/category_binding.dart';
import '../modules/category/views/category_view.dart';
import '../modules/checkout/bindings/checkout_binding.dart';
import '../modules/checkout/views/checkout_view.dart';
import '../modules/delivery_address/add_delivery_address/bindings/add_delivary_address_binding.dart';
import '../modules/delivery_address/add_delivery_address/views/add_delivary_address_view.dart';
import '../modules/delivery_address/bindings/delivery_address_binding.dart';
import '../modules/delivery_address/views/delivery_address_view.dart';
import '../modules/forgot_password/bindings/forgot_password_binding.dart';
import '../modules/forgot_password/views/forgot_password_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/main_page/bindings/main_page_binding.dart';
import '../modules/main_page/views/main_page_view.dart';
import '../modules/notification/bindings/notification_binding.dart';
import '../modules/notification/views/notification_view.dart';
import '../modules/onboard/bindings/onboard_binding.dart';
import '../modules/onboard/views/onboard_view.dart';
import '../modules/orders/bindings/orders_binding.dart';
import '../modules/orders/order_details/bindings/order_details_binding.dart';
import '../modules/orders/order_details/views/order_details_view.dart';
import '../modules/orders/views/orders_view.dart';
import '../modules/payment_methods/bindings/payment_methods_binding.dart';
import '../modules/payment_methods/views/payment_methods_view.dart';
import '../modules/products/bindings/products_binding.dart';
import '../modules/products/product_details/bindings/product_details_binding.dart';
import '../modules/products/product_details/views/product_details_view.dart';
import '../modules/products/views/products_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/edit_profile/bindings/edit_profile_binding.dart';
import '../modules/profile/edit_profile/views/edit_profile_view.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/register/bindings/register_binding.dart';
import '../modules/register/views/register_view.dart';
import '../modules/splash_screen/bindings/splash_screen_binding.dart';
import '../modules/splash_screen/views/splash_screen_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH_SCREEN;

  static final routes = [
    GetPage(
      name: _Paths.SPLASH_SCREEN,
      page: () => const SplashScreenView(),
      binding: SplashScreenBinding(),
    ),
    GetPage(
      name: _Paths.ADMIN,
      page: () => const AdminView(),
      binding: AdminBinding(),
      children: [
        GetPage(
          name: _Paths.ADMIN_MAIN_PAGE,
          page: () => const AdminMainPageView(),
          binding: AdminMainPageBinding(),
        ),
        GetPage(
          name: _Paths.DASHBOARD,
          page: () => const DashboardView(),
          binding: DashboardBinding(),
        ),
        GetPage(
          name: _Paths.FINANCIAL,
          page: () => const FinancialView(),
          binding: FinancialBinding(),
        ),
        GetPage(
          name: _Paths.RECENT_ORDERS,
          page: () => const RecentOrdersView(),
          binding: RecentOrdersBinding(),
          children: [
            GetPage(
              name: _Paths.ALL_ORDERS,
              page: () => const AllOrdersView(),
              binding: AllOrdersBinding(),
            ),
            GetPage(
              name: _Paths.ORDER_INFO,
              page: () => const OrderInfoView(),
              binding: OrderInfoBinding(),
            ),
          ],
        ),
        GetPage(
          name: _Paths.SALES_SUMMARY,
          page: () => const SalesSummaryView(),
          binding: SalesSummaryBinding(),
        ),
        GetPage(
          name: _Paths.ADD_PRODUCT,
          page: () => const AddProductView(),
          binding: AddProductBinding(),
        ),
        GetPage(
          name: _Paths.CUSTOMERS,
          page: () => const CustomersView(),
          binding: CustomersBinding(),
          children: [
            GetPage(
              name: _Paths.CUSTOMER_DETAILS,
              page: () => const CustomerDetailsView(),
              binding: CustomerDetailsBinding(),
            ),
          ],
        ),
        GetPage(
          name: _Paths.EDIT_PRODUCT,
          page: () => const EditProductView(),
          binding: EditProductBinding(),
        ),
        GetPage(
          name: _Paths.STOCKS,
          page: () => const StocksView(),
          binding: StocksBinding(),
          children: [
            GetPage(
              name: _Paths.STOCK_DETAILS,
              page: () => const StockDetailsView(),
              binding: StockDetailsBinding(),
            ),
          ],
        ),
        GetPage(
          name: _Paths.ADD_CATEGORY,
          page: () => const AddCategoryView(),
          binding: AddCategoryBinding(),
        ),
      ],
    ),
    GetPage(
      name: _Paths.CART,
      page: () => const CartView(),
      binding: CartBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => const RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.FORGOT_PASSWORD,
      page: () => const ForgotPasswordView(),
      binding: ForgotPasswordBinding(),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.MAIN_PAGE,
      page: () => const MainPageView(),
      binding: MainPageBinding(),
    ),
    GetPage(
      name: _Paths.NOTIFICATION,
      page: () => const NotificationView(),
      binding: NotificationBinding(),
    ),
    GetPage(
      name: _Paths.ONBOARD,
      page: () => const OnboardView(),
      binding: OnboardBinding(),
    ),
    GetPage(
      name: _Paths.ORDERS,
      page: () => const OrdersView(),
      binding: OrdersBinding(),
      children: [
        GetPage(
          name: _Paths.ORDER_DETAILS,
          page: () => const OrderDetailsView(),
          binding: OrderDetailsBinding(),
        ),
      ],
    ),
    GetPage(
      name: _Paths.PRODUCTS,
      page: () => const ProductsView(),
      binding: ProductsBinding(),
      children: [
        GetPage(
          name: _Paths.PRODUCT_DETAILS,
          page: () => const ProductDetailsView(),
          binding: ProductDetailsBinding(),
        ),
      ],
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
      children: [
        GetPage(
          name: _Paths.EDIT_PROFILE,
          page: () => const EditProfileView(),
          binding: EditProfileBinding(),
        ),
      ],
    ),
    GetPage(
      name: _Paths.CHECKOUT,
      page: () => const CheckoutView(),
      binding: CheckoutBinding(),
    ),
    GetPage(
      name: _Paths.PAYMENT_METHODS,
      page: () => const PaymentMethodsView(),
      binding: PaymentMethodsBinding(),
    ),
    GetPage(
      name: _Paths.DELIVERY_ADDRESS,
      page: () => const DeliveryAddressView(),
      binding: DeliveryAddressBinding(),
      children: [
        GetPage(
          name: _Paths.ADD_DELIVARY_ADDRESS,
          page: () => const AddDeliveryAddressView(),
          binding: AddDeliveryAddressBinding(),
        ),
      ],
    ),
    GetPage(
      name: _Paths.CATEGORY,
      page: () => const CategoryView(),
      binding: CategoryBinding(),
    ),
  ];
}
