import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:revalesuva/model/empty_model/empty_model.dart';
import 'package:revalesuva/model/workshop_events/create_workshop_event_model.dart';
import 'package:revalesuva/model/workshop_events/future_workshop_event_model.dart'
    as future_workshop_event_model;
import 'package:revalesuva/model/workshop_events/past_workshop_event_model.dart'
    as past_workshop_event_model;
import 'package:revalesuva/model/workshop_events/workshop_event_model.dart' as workshop_event_model;
import 'package:revalesuva/repository/repository.dart';
import 'package:revalesuva/services/api_status.dart';
import 'package:revalesuva/utils/helper_method.dart';
import 'package:revalesuva/utils/strings_constant.dart';

class WorkshopEventViewModel extends GetxController {
  var listWorkshopEvent = <workshop_event_model.Datum>[].obs;
  var perPage = "10";
  var currentPage = 1.obs;
  var total = 1.obs;
  ScrollController scrollController = ScrollController();
  var isLoading = false.obs;
  var isLoadingMore = false.obs;

  var listPastEvent = <past_workshop_event_model.Datum>[].obs;
  var pastEventPerPage = "10";
  var pastEventCurrentPage = 1.obs;
  var pastEventTotal = 1.obs;
  ScrollController pastEventScrollController = ScrollController();
  var pastEventIsLoading = false.obs;
  var pastEventIsLoadingMore = false.obs;

  var listFutureEvent = <future_workshop_event_model.Datum>[].obs;
  var isFutureLoading = false.obs;

  var txtFullName = TextEditingController().obs;
  var txtEmail = TextEditingController().obs;
  var txtPhone = TextEditingController().obs;
  var txtStreet = TextEditingController().obs;
  var txtHouse = TextEditingController().obs;
  var txtApartment = TextEditingController().obs;
  var txtZipcode = TextEditingController().obs;
  var txtCity = "".obs;
  var isEditMode = false.obs;
  var isHide = false.obs;

  setupScrollController() {
    scrollController = ScrollController();
    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent &&
          !isLoadingMore.value) {
        loadMore();
      }
    });
  }

  void loadMore() {
    if (listWorkshopEvent.length < total.value) {
      currentPage.value++;
      fetchWorkshopEvent(isLoadMore: true);
    }
  }

  fetchWorkshopEvent({bool isLoadMore = false}) async {
    if (isLoadMore) {
      isLoadingMore.value = true;
    } else {
      isLoading.value = true;
    }
    var response = await Repository.instance.getWorkshopEventApi(
      perPage: perPage,
      page: currentPage.value.toString(),
    );
    if (response is Success) {
      var result = workshop_event_model.workshopEventModelFromJson(response.response.toString());
      if (isLoadMore) {
        listWorkshopEvent.addAll(result.data?.data ?? <workshop_event_model.Datum>[]);
      } else {
        listWorkshopEvent.value = result.data?.data ?? [];
      }
      total.value = result.data?.totalItems ?? 1;
    } else if (response is Failure) {
      listWorkshopEvent.clear();
    }
    if (isLoadMore) {
      isLoadingMore.value = false;
    } else {
      isLoading.value = false;
    }
  }

  //past workshop
  pastSetupScrollController() {
    pastEventScrollController = ScrollController();
    pastEventScrollController.addListener(() {
      if (pastEventScrollController.position.pixels ==
              pastEventScrollController.position.maxScrollExtent &&
          !pastEventIsLoadingMore.value) {
        pastLoadMore();
      }
    });
  }

  void pastLoadMore() {
    if (listPastEvent.length < pastEventTotal.value) {
      pastEventCurrentPage.value++;
      pastFetchWorkshopEvent(isLoadMore: true);
    }
  }

  pastFetchWorkshopEvent({bool isLoadMore = false}) async {
    if (isLoadMore) {
      pastEventIsLoadingMore.value = true;
    } else {
      pastEventIsLoading.value = true;
    }
    var response = await Repository.instance.getPastWorkshopEventApi(
      perPage: pastEventPerPage,
      page: pastEventCurrentPage.value.toString(),
    );
    if (response is Success) {
      var result =
          past_workshop_event_model.pastWorkshopEventModelFromJson(response.response.toString());
      if (isLoadMore) {
        listPastEvent.addAll(result.data?.data ?? <past_workshop_event_model.Datum>[]);
      } else {
        listPastEvent.value = result.data?.data ?? [];
      }
      pastEventTotal.value = result.data?.totalItems ?? 1;
    } else if (response is Failure) {
      listPastEvent.clear();
    }
    if (isLoadMore) {
      pastEventIsLoadingMore.value = false;
    } else {
      pastEventIsLoading.value = false;
    }
  }

  //Future

  fetchFutureWorkshopEvent() async {
    isFutureLoading.value = true;
    var response = await Repository.instance.getFutureWorkshopEventApi();
    if (response is Success) {
      var result =
          future_workshop_event_model.futureWorkshopEventModelFromJson(response.response.toString());
      listFutureEvent.assignAll(result.data ?? []);
    } else if (response is Failure) {
      listFutureEvent.clear();
    }
    isFutureLoading.value = false;
  }

  //create workshop
  Future<bool> createWorkshopEvent({required workshop_event_model.Datum event}) async {
    if (txtApartment.value.text.isEmpty) {
      showToast(msg: "${StringConstants.apartment} ${StringConstants.required}");
    } else if (txtCity.value.isEmpty) {
      showToast(msg: "${StringConstants.city} ${StringConstants.required}");
    } else if (txtEmail.value.text.isEmpty) {
      showToast(msg: "${StringConstants.email} ${StringConstants.required}");
    } else if (txtHouse.value.text.isEmpty) {
      showToast(msg: "${StringConstants.house} ${StringConstants.required}");
    } else if (txtPhone.value.text.isEmpty) {
      showToast(msg: "${StringConstants.phoneNumber} ${StringConstants.required}");
    } else if (txtStreet.value.text.isEmpty) {
      showToast(msg: "${StringConstants.street} ${StringConstants.required}");
    } else if (txtZipcode.value.text.isEmpty) {
      showToast(msg: "${StringConstants.postalCode} ${StringConstants.required}");
    } else {
      showLoader();
      var data = CreateWorkshopEventModel(
        price: double.tryParse(event.price.toString()),
        apartment: txtApartment.value.text,
        city: txtCity.value,
        email: txtEmail.value.text,
        house: txtHouse.value.text,
        participantName: txtFullName.value.text,
        phoneNumber: txtPhone.value.text,
        street: txtStreet.value.text,
        workshopEventId: event.id,
        zipcode: txtZipcode.value.text,
      );

      var response = await Repository.instance.createWorkshopEventApi(
        workshop: CreateWorkshopEventModel(
          price: double.tryParse(event.price.toString()),
          apartment: txtApartment.value.text,
          city: txtCity.value,
          email: txtEmail.value.text,
          house: txtHouse.value.text,
          participantName: txtFullName.value.text,
          phoneNumber: txtPhone.value.text,
          street: txtStreet.value.text,
          workshopEventId: event.id,
          zipcode: txtZipcode.value.text,
        ),
      );
      hideLoader();
      if (response is Success) {
        var result = emptyModelFromJson(response.response.toString());
        showToast(msg: result.message ?? "");
        return true;
      } else if (response is Failure) {
        showToast(msg: "${response.errorResponse ?? ""}");
      }
    }
    return false;
  }

  //create workshop
  Future<bool> updateWorkshopEvent({required future_workshop_event_model.Datum? event}) async {
    if (event?.id == null) {
      showToast(msg: "Id ${StringConstants.required}");
    } else if (txtApartment.value.text.isEmpty) {
      showToast(msg: "${StringConstants.apartment} ${StringConstants.required}");
    } else if (txtCity.value.isEmpty) {
      showToast(msg: "${StringConstants.city} ${StringConstants.required}");
    } else if (txtEmail.value.text.isEmpty) {
      showToast(msg: "${StringConstants.email} ${StringConstants.required}");
    } else if (txtHouse.value.text.isEmpty) {
      showToast(msg: "${StringConstants.house} ${StringConstants.required}");
    } else if (txtPhone.value.text.isEmpty) {
      showToast(msg: "${StringConstants.phoneNumber} ${StringConstants.required}");
    } else if (txtStreet.value.text.isEmpty) {
      showToast(msg: "${StringConstants.street} ${StringConstants.required}");
    } else if (txtZipcode.value.text.isEmpty) {
      showToast(msg: "${StringConstants.postalCode} ${StringConstants.required}");
    } else {
      showLoader();
      var response = await Repository.instance.createWorkshopEventApi(
        workshop: CreateWorkshopEventModel(
          userWorkshopEventId: event?.id,
          apartment: txtApartment.value.text,
          city: txtCity.value,
          email: txtEmail.value.text,
          house: txtHouse.value.text,
          price: double.tryParse(event?.workShopEvent?.price),
          participantName: txtFullName.value.text,
          phoneNumber: txtPhone.value.text,
          street: txtStreet.value.text,
          workshopEventId: event?.workshopEventId,
          zipcode: txtZipcode.value.text,
        ),
      );
      hideLoader();
      if (response is Success) {
        var result = emptyModelFromJson(response.response.toString());
        showToast(msg: result.message ?? "");
        return true;
      } else if (response is Failure) {
        showToast(msg: "${response.errorResponse ?? ""}");
      }
    }
    return false;
  }

  Future<bool> deleteWorkshopEventById({required int eventId}) async {
    showLoader();
    var response = await Repository.instance.deleteEventApi(eventId: eventId);
    hideLoader();
    if (response is Success) {
      var result = emptyModelFromJson(response.response.toString());
      showToast(msg: result.message ?? "");
      var data = listFutureEvent.indexWhere(
        (element) => element.id == eventId,
      );
      listFutureEvent.removeAt(data);
      listFutureEvent.refresh();
      return true;
    } else if (response is Failure) {
      showToast(msg: "${response.errorResponse ?? ""}");
    }
    return false;
  }
}
