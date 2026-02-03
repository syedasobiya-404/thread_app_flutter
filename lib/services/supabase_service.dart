import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService extends GetxService {
  static final SupabaseClient client = Supabase.instance.client;
  static Rx<User?> currentUser = Rx<User?>(null);

  @override
  Future<void> onInit() async {
    await Supabase.initialize(
      url: "https://qqdxcqiakaxrshnwbvxt.supabase.co",
      anonKey:
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InFxZHhjcWlha2F4cnNobndidnh0Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDc3MzgyMzUsImV4cCI6MjA2MzMxNDIzNX0.aypiAFSN21egGAqnQ4q_hRoAQDIDMaseEUD5PDO0Bc8",
    );
    listenOnAuthChanges();
    super.onInit();
  }

  void listenOnAuthChanges() {
    client.auth.onAuthStateChange.listen(
      (event) {
        final AuthChangeEvent authChangeEvent = event.event;

        if (authChangeEvent == AuthChangeEvent.userUpdated) {
          currentUser.value = event.session?.user;
        } else if (authChangeEvent == AuthChangeEvent.signedIn) {
          currentUser.value = event.session?.user;
        }
      },
    );
  }
}
