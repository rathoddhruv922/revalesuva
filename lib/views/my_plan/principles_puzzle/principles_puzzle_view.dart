import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:image/image.dart' as img;
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:revalesuva/components/custom_Image_viewer.dart';
import 'package:revalesuva/components/custom_click.dart';
import 'package:revalesuva/components/custom_text.dart';
import 'package:revalesuva/generated/assets.dart';
import 'package:revalesuva/utils/app_colors.dart';
import 'package:revalesuva/utils/navigation_helper.dart';
import 'package:revalesuva/utils/strings_constant.dart';
import 'package:revalesuva/view_models/my_plan/puzzle_view_model.dart';
import 'package:revalesuva/view_models/user_view_model.dart';
import 'package:revalesuva/views/my_plan/principles_puzzle/widget/jigsaw_puzzel_componets.dart';
import 'package:widgets_to_image/widgets_to_image.dart';

class PrinciplesPuzzleView extends StatefulWidget {
  const PrinciplesPuzzleView({
    super.key,
    required this.planId,
  });

  final String planId;

  @override
  State<PrinciplesPuzzleView> createState() => _PrinciplesPuzzleViewState();
}

class _PrinciplesPuzzleViewState extends State<PrinciplesPuzzleView> {
  List<Uint8List> imagePieces = [];
  int cols = 3, rows = 3;
  WidgetsToImageController controller = WidgetsToImageController();
  Uint8List? bytes;
  final GlobalKey globalKey = GlobalKey();
  List<int> showPiecesList = [];

  final PuzzleViewModel puzzleViewModel = Get.put(PuzzleViewModel());

  @override
  void initState() {
    super.initState();
    // loadAndSplitImage(23);
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        puzzleViewModel.isLoading.value = true;
        await puzzleViewModel.getTaskByPlanId(
          planId: widget.planId,
        );
        await puzzleViewModel.getUserTaskByPlanId(
          planId: widget.planId,
        );

        await Future.delayed(
          const Duration(
            seconds: 2,
          ),
        );

        img.Image? image = await widgetToImage(globalKey);
        loadAndSplitImage2(
          numPieces: puzzleViewModel.taskTotal.value,
          totalShowing: puzzleViewModel.userTaskTotal.value,
          data: image!,
        );
        puzzleViewModel.isLoading.value = false;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, result) {
        NavigationHelper.onBackScreen(
          widget: PrinciplesPuzzleView(
            planId: widget.planId,
          ),
        );
      },
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Gap(5),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: CustomClick(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: TextBodySmall(
                  text: "< ${StringConstants.backTo} ${StringConstants.myPlan}",
                  color: AppColors.textPrimary,
                  letterSpacing: 0,
                ),
              ),
            ),
            const Gap(5),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextHeadlineMedium(text: StringConstants.iceTherapy),
            ),
            Flexible(
              child: ListView(
                physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                    child: Directionality(
                      textDirection: TextDirection.ltr,
                      child: AspectRatio(
                        aspectRatio: 0.609,
                        child: Stack(
                          children: [
                            RepaintBoundary(
                              key: globalKey,
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  LayoutBuilder(
                                    builder: (context, constraints) {
                                      final double bgWeight = constraints.maxWidth;
                                      return Container(
                                        width: bgWeight * 0.50,
                                        height: bgWeight * 0.50,
                                        margin: EdgeInsets.only(
                                          bottom: constraints.maxHeight * 0.26,
                                          right: constraints.maxWidth * 0.03,
                                        ),
                                        child: AspectRatio(
                                          aspectRatio: 1 / 1,
                                          child: CustomImageViewer(
                                            imageUrl:
                                                Get.find<UserViewModel>().userData.value.profileImage,
                                            // imageUrl:
                                            //     "https://gratisography.com/wp-content/uploads/2024/11/gratisography-augmented-reality-800x525.jpg",
                                            errorImage: Image.asset(
                                              Assets.imagesImProfilePlaceholder,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  Image.asset(
                                    Assets.imagesBgVictory,
                                    fit: BoxFit.fitWidth,
                                    width: MediaQuery.of(context).size.width,
                                  ),
                                ],
                              ),
                            ),
                            Obx(
                              () {
                                var isSame = puzzleViewModel.taskTotal.value ==
                                    puzzleViewModel.userTaskTotal.value;
                                return isSame
                                    ? const SizedBox()
                                    : Stack(
                                        children: [
                                          Obx(
                                            () => puzzleViewModel.isLoading.value
                                                ? Container(
                                                    width: 100.w,
                                                    height: 100.h,
                                                    alignment: Alignment.center,
                                                    decoration: const BoxDecoration(
                                                      color: AppColors.surfaceTertiary,
                                                    ),
                                                    child: SizedBox(
                                                      width: 100.w,
                                                      height: 40.h,
                                                      child:
                                                          const CupertinoActivityIndicator(radius: 20),
                                                    ),
                                                  )
                                                : const SizedBox(),
                                          ),
                                          MasonryGridView.count(
                                            physics: const NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            crossAxisCount: cols,
                                            crossAxisSpacing: 0,
                                            mainAxisSpacing: 0,
                                            itemCount: imagePieces.length,
                                            itemBuilder: (context, index) {
                                              bool myShow =
                                                  showPiecesList.contains(index) ? false : true;
                                              return CustomPaint(
                                                painter: JigsawPainter(
                                                    cols: cols,
                                                    rows: rows,
                                                    index: index,
                                                    isShow: myShow,
                                                    showPiecesList: showPiecesList), // Draws the border
                                                child: ClipPath(
                                                  clipBehavior: Clip.hardEdge,
                                                  clipper: JigsawClipper(
                                                    cols: cols,
                                                    rows: rows,
                                                    index: index,
                                                    isShow: myShow,
                                                    showPiecesList: showPiecesList,
                                                  ),
                                                  child: Container(
                                                    decoration: const BoxDecoration(
                                                        color: AppColors.surfaceTertiary),
                                                    child: Stack(
                                                      alignment: Alignment.bottomLeft,
                                                      children: [
                                                        Opacity(
                                                          opacity: myShow ? 0.0 : 1.0,
                                                          child: Image.memory(imagePieces[index]),
                                                        ),
                                                        Align(
                                                          alignment: Alignment.bottomLeft,
                                                          child: Container(
                                                            height: 20,
                                                            width: 20,
                                                            margin: const EdgeInsets.all(2),
                                                            padding: const EdgeInsets.all(4.0),
                                                            decoration: BoxDecoration(
                                                              shape: BoxShape.circle,
                                                              color: AppColors.surfaceTertiary,
                                                              border: Border.all(
                                                                color: AppColors.borderSecondary,
                                                              ),
                                                            ),
                                                            child: FittedBox(
                                                              child: TextTitleSmall(
                                                                text: '${index + 1}',
                                                                color: AppColors.textPrimary,
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
                                        ],
                                      );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<img.Image?> widgetToImage(GlobalKey key) async {
    try {
      RenderRepaintBoundary? boundary = key.currentContext?.findRenderObject() as RenderRepaintBoundary?;

      if (boundary == null) return null;

      ui.Image uiImage = await boundary.toImage();
      ByteData? byteData = await uiImage.toByteData(format: ui.ImageByteFormat.png);
      Uint8List? uint8List = byteData?.buffer.asUint8List();

      if (uint8List == null) return null;

      return img.decodeImage(uint8List);
    } catch (e) {
      debugPrint("Error converting widget to image: $e");
      return null;
    }
  }

  Future<img.Image?> loadAssetImage(String assetPath) async {
    try {
      // Load image data from assets
      ByteData data = await rootBundle.load(assetPath);
      Uint8List bytes = data.buffer.asUint8List();

      // Decode image
      img.Image? image = img.decodeImage(bytes);
      return image;
    } catch (e) {
      print('Error loading asset image: $e');
      return null;
    }
  }

  Future<img.Image?> loadFileImage(String filePath) async {
    try {
      // Read file as bytes
      File file = File(filePath);
      Uint8List bytes = await file.readAsBytes();

      // Decode image
      img.Image? image = img.decodeImage(bytes);
      return image;
    } catch (e) {
      debugPrint('Error loading file image: $e');
      return null;
    }
  }

  Future<void> loadAndSplitImage(int numPieces) async {
    try {
      img.Image? image = await loadAssetImage(Assets.imagesBgVictory);
      if (image != null) {
        int imageWidth = image.width;
        int imageHeight = image.height;

        cols = sqrt(numPieces).ceil();
        rows = (numPieces / cols).ceil();

        int pieceWidth = (imageWidth / cols).round();
        int pieceHeight = (imageHeight / rows).round();

        List<img.Image> croppedImages = [];

        for (int row = 0; row < rows; row++) {
          for (int col = 0; col < cols; col++) {
            croppedImages.add(img.copyCrop(
              image,
              x: col * pieceWidth,
              y: row * pieceHeight,
              width: pieceWidth,
              height: pieceHeight,
            ));
          }
        }

        setState(() {
          imagePieces = croppedImages.map((img.Image croppedImage) {
            return Uint8List.fromList(img.encodePng(croppedImage));
          }).toList();
        });
      }
    } catch (e) {
      debugPrint("Error fetching image: $e");
    }
  }

  Future<void> loadAndSplitImage2({
    required int numPieces,
    required img.Image data,
    required int totalShowing,
  }) async {
    try {
      img.Image? image = data;
      int imageWidth = image.width;
      int imageHeight = image.height;

      cols = sqrt(numPieces).ceil();
      rows = (numPieces / cols).ceil();

      int pieceWidth = (imageWidth / cols).round();
      int pieceHeight = (imageHeight / rows).round();

      List<img.Image> croppedImages = [];

      for (int row = 0; row < rows; row++) {
        for (int col = 0; col < cols; col++) {
          croppedImages.add(img.copyCrop(
            image,
            x: col * pieceWidth,
            y: row * pieceHeight,
            width: pieceWidth,
            height: pieceHeight,
          ));
        }
      }

      setState(() {
        imagePieces = croppedImages.map((img.Image croppedImage) {
          return Uint8List.fromList(img.encodePng(croppedImage));
        }).toList();
        showPiecesList = getRoundedPattern(
          cols: cols,
          rows: rows,
          totalOpenPieces: puzzleViewModel.userTaskTotal.value,
        );
      });
    } catch (e) {
      debugPrint("Error fetching image: $e");
    }
  }
}

List<int> getRoundedPattern({required int rows, required int cols, required int totalOpenPieces}) {
  int totalPieces = rows * cols;
  List<int> indices = [];

  // Define layers from outer to inner
  int layer = 0;
  int count = 0;
  List<List<int>> grid = List.generate(rows, (i) => List.generate(cols, (j) => i * cols + j));

  while (count < totalOpenPieces) {
    // Top row
    for (int i = layer; i < cols - layer && count < totalOpenPieces; i++) {
      if (!indices.contains(grid[layer][i])) {
        indices.add(grid[layer][i]);
        count++;
      }
    }

    // Right column
    for (int i = layer + 1; i < rows - layer && count < totalOpenPieces; i++) {
      if (!indices.contains(grid[i][cols - layer - 1])) {
        indices.add(grid[i][cols - layer - 1]);
        count++;
      }
    }

    // Bottom row
    for (int i = cols - layer - 2; i >= layer && count < totalOpenPieces; i--) {
      if (!indices.contains(grid[rows - layer - 1][i])) {
        indices.add(grid[rows - layer - 1][i]);
        count++;
      }
    }

    // Left column
    for (int i = rows - layer - 2; i > layer && count < totalOpenPieces; i--) {
      if (!indices.contains(grid[i][layer])) {
        indices.add(grid[i][layer]);
        count++;
      }
    }

    layer++;
  }

  return indices;
}
