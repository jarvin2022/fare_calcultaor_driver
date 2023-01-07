import 'package:fair_calculator_driver/packages.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fair_calculator_driver/History/View/historty_transaction_view.dart';

class HistoryView extends GetView<UserController> {
  const HistoryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: 50,
            height: 50,
            decoration: const BoxDecoration(boxShadow: [
              BoxShadow(color: Colors.black12, blurRadius: 1, spreadRadius: 1),
            ], borderRadius: BorderRadius.all(Radius.circular(12))),
            child: Container(
              width: 50,
              height: 50,
              decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 78, 176, 18),
                  borderRadius: BorderRadius.all(Radius.circular(12))),
              child: Center(
                child: IconButton(
                    splashColor: Colors.transparent,
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(
                      Icons.arrow_back_rounded,
                      color: Colors.white,
                    )),
              ),
            ),
          ),
        ),
        flexibleSpace: Container(
          width: Get.width,
          height: 35,
          color: const Color.fromARGB(255, 78, 176, 18),
        ),
      ),
      body: SafeArea(
        child: SizedBox(
          width: Get.width,
          height: Get.height,
          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 180,
                    height: 180,
                    child: SvgPicture.asset('./assets/logo/history_logo.svg'),
                  ),
                  SizedBox(
                    width: 150,
                    height: 200,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        TextWidget(
                          title: 'Your\nTransaction\nHistory',
                          color: Color.fromARGB(255, 79, 88, 88),
                          fontSized: 20,
                          fontWeight: FontWeight.w700,
                        )
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(
                  width: Get.width,
                  height: Get.height * 0.63,
                  child: NotificationListener<OverscrollIndicatorNotification>(
                    onNotification: (_) => false,
                    child: Obx(
                      (() => ListView.builder(
                          itemCount:
                              controller.hicontroller!.historyList.length,
                          itemBuilder: ((context, index) {
                            return Slidable(
                              endActionPane: ActionPane(
                                motion: const ScrollMotion(),
                                children: [
                                  SlidableAction(
                                    // An action can be bigger than the others.
                                    flex: 1,
                                    backgroundColor: Colors.red,
                                    foregroundColor: Colors.white,
                                    icon: Icons.delete,
                                    label: 'remove',
                                    onPressed: ((context) =>
                                        controller.hicontroller!.removeHistory(
                                            index,
                                            controller
                                                .hicontroller!
                                                .historyList[index]
                                                .historyID!)),
                                  ),
                                ],
                              ),
                              child: InkWell(
                                onTap: (() => Get.to(() =>
                                    HistoryTransactionView(
                                        historyModel: controller.hicontroller!
                                            .historyList[index]))),
                                child: transactionWidget(controller
                                    .hicontroller!.historyList[index]),
                              ),
                            );
                          }))),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  Widget transactionWidget(HistoryModel historyModel) {
    return Container(
      width: Get.width,
      height: 90,
      margin:
          const EdgeInsets.only(left: 15.0, top: 5.0, right: 15.0, bottom: 5.0),
      decoration: const BoxDecoration(boxShadow: [
        BoxShadow(color: Colors.black12, blurRadius: 0.1, spreadRadius: .3)
      ], borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Container(
        width: Get.width,
        height: 90,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 50,
                height: 50,
                child: Hero(
                    tag: historyModel.historyID ?? '',
                    child: SvgPicture.asset('./assets/logo/Logo.svg')),
              ),
              const SizedBox(width: 10),
              SizedBox(
                width: 240,
                height: 70,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const SizedBox(height: 5),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextWidget(
                            title: 'Distance : ${historyModel.historyDistance}',
                            fontSized: 12,
                            fontWeight: FontWeight.w500,
                          ),
                          TextWidget(
                            title: 'Duration : ${historyModel.historyDuration}',
                            fontSized: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ]),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextWidget(
                          title:
                              'Fare : ${PriceClass().priceFormat(historyModel.historyFare ?? 0)}',
                          fontSized: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}