import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:revalesuva/model/podcast/podcast_hosts_model.dart' as podcast_hosts_model;
import 'package:revalesuva/model/podcast/podcast_model.dart' as podcast_model;
import 'package:revalesuva/repository/repository.dart';
import 'package:revalesuva/services/api_status.dart';

class PodcastViewModel extends GetxController {
  var listPodcast = <podcast_model.Datum>[].obs;
  var isLoading = false.obs;
  var perPage = "10";
  var currentPage = 1.obs;
  var total = 1.obs;
  ScrollController scrollController = ScrollController();
  var isLoadingMore = false.obs;

  var listHost = <podcast_hosts_model.Datum>[].obs;
  var isLoadingHost = false.obs;
  var perPageHost = "10";
  var currentPageHost = 1.obs;
  var totalHost = 1.obs;
  ScrollController scrollControllerHost = ScrollController();
  var isLoadingMoreHost = false.obs;

  setupScrollController({required String hostId}) {
    scrollController = ScrollController();
    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent &&
          !isLoadingMore.value) {
        loadMore(hostId: hostId);
      }
    });
  }

  void loadMore({required String hostId}) {
    if (listPodcast.length < total.value) {
      currentPage.value++;
      getPodcastByHost(isLoadMore: true, hostId: hostId);
    }
  }

  getPodcastByHost({bool isLoadMore = false, required String hostId}) async {
    if (isLoadMore) {
      isLoadingMore.value = true;
    } else {
      isLoading.value = true;
    }
    var response = await Repository.instance.getPodcastApi(
      perPage: perPage,
      page: currentPage.value.toString(),
      hostId: hostId,
    );
    if (response is Success) {
      var result = podcast_model.podcastModelFromJson(response.response.toString());
      if (isLoadMore) {
        listPodcast.addAll(result.data?.data ?? <podcast_model.Datum>[]);
      } else {
        listPodcast.value = result.data?.data ?? [];
      }
      total.value = result.data?.totalItems ?? 1;
    } else if (response is Failure) {
      listPodcast.clear();
    }
    if (isLoadMore) {
      isLoadingMore.value = false;
    } else {
      isLoading.value = false;
    }
  }

  setupScrollControllerHost() {
    scrollControllerHost = ScrollController();
    scrollControllerHost.addListener(() {
      if (scrollControllerHost.position.pixels == scrollControllerHost.position.maxScrollExtent &&
          !isLoadingMoreHost.value) {
        loadMoreHost();
      }
    });
  }

  void loadMoreHost() {
    if (listHost.length < totalHost.value) {
      currentPageHost.value++;
      fetchHost(isLoadMore: true);
    }
  }

  fetchHost({bool isLoadMore = false}) async {
    if (isLoadMore) {
      isLoadingMoreHost.value = true;
    } else {
      isLoadingHost.value = true;
    }
    var response = await Repository.instance.getPodcastHostsApi(
      perPage: perPageHost,
      page: currentPageHost.value.toString(),
    );
    if (response is Success) {
      var result = podcast_hosts_model.podcastHostsModelFromJson(response.response.toString());
      if (isLoadMore) {
        listHost.addAll(result.data?.data ?? <podcast_hosts_model.Datum>[]);
      } else {
        listHost.value = result.data?.data ?? [];
      }
      totalHost.value = result.data?.totalItems ?? 1;
    } else if (response is Failure) {
      listHost.clear();
    }
    if (isLoadMore) {
      isLoadingMoreHost.value = false;
    } else {
      isLoadingHost.value = false;
    }
  }
}
