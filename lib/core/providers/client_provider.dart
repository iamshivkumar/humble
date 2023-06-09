
import 'package:appwrite/appwrite.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';


final clientProvider = Provider<Client>(
  (ref)  {
    final channel = Client(
      endPoint: "https://cloud.appwrite.io/v1",
    );
    channel.setProject("6472f8e636a915c8dc64");
    channel.setSelfSigned();
    return channel;
  },
);