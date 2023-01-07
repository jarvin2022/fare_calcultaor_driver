import 'package:fair_calculator_driver/main.dart';
import 'package:fair_calculator_driver/packages.dart';

class HistoryController extends GetxController {
  RxList<HistoryModel> historyList = RxList<HistoryModel>([]).obs();

  @override
  void onInit() {
    super.onInit();
    initStream();
  }

  void initStream() => historyList.bindStream(historyStream());

  Stream<List<HistoryModel>> historyStream() {
    List<HistoryModel> list = [];

    Stream<QuerySnapshot> res = firebaseFirestore
        .collection(historyCollection)
        .where('history_userID', isEqualTo: firebaseAuth.currentUser!.uid)
        .snapshots();

    res.listen((response) {
      if (response.docs.isNotEmpty) {
        list.clear();
      }
    });

    return res.map((response) {
      for (QueryDocumentSnapshot document in response.docs) {
        if (document.get('history_userID') == firebaseAuth.currentUser!.uid) {
          list.add(HistoryModel.toJson(
              document.data() as Map<String, dynamic>, document.id));
        }
      }
      return list.toList();
    });
  }

  void removeHistory(int index, String id) => requestDeleteDocument(index, id);

  void requestDeleteDocument(int index, String id) async {
    try {
      historyList.removeAt(index);
      firebaseFirestore.collection(historyCollection).doc(id).delete();
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}