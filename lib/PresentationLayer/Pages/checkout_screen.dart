import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:camera/camera.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:infoinstall/DataLayer/Model/remove_device_model.dart';
import 'package:infoinstall/PresentationLayer/Bloc/Blocs/checkout_bloc.dart';
import 'package:infoinstall/PresentationLayer/Bloc/Blocs/remove_device_bloc.dart';
import 'package:infoinstall/PresentationLayer/Bloc/Events/checkout_event.dart';
import 'package:infoinstall/PresentationLayer/Bloc/Events/remove_device_event.dart';
import 'package:infoinstall/PresentationLayer/Bloc/States/checkout_state.dart';
import 'package:infoinstall/PresentationLayer/Bloc/States/remove_device_state.dart';
import 'package:infoinstall/PresentationLayer/Components/color_plattes.dart';
import 'package:infoinstall/PresentationLayer/Components/print_mixin.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';

import '../../DataLayer/Model/checkout_device_model.dart';
import '../../DataLayer/Model/device_list_detail_model.dart';
import '../../DataLayer/Model/job_list_item_model.dart';
import '../Components/text_style.dart';
import '../Components/toast_message.dart';
import '../Widgets/app_bar_widget.dart';
import '../Widgets/custom_button.dart';
import '../Widgets/custome_icon_widget.dart';
import 'dart:ui' as ui;

// Removed unused imports flagged by linter

import '../Widgets/job_details_card_widget.dart';

class CheckOutScreen extends StatefulWidget {
  // final AddJobRequestModel addJobRequestModel;
  final DeviceListDetailsModel deviceListDetailsModel;
  final JobListDetailsModel jobDetails;
  final BuildContext context;
  final int deviceLenght;
  const CheckOutScreen(this.context, this.jobDetails,
      this.deviceListDetailsModel, this.deviceLenght,
      {Key? key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> with PrintMixin {
  List<String> listOfImages = [];
  List<String> listOfBaseImages = [];
  bool _isSigned = false;
  late Uint8List _signatureData = Uint8List(0);
  final GlobalKey<SfSignaturePadState> _signaturePadKey = GlobalKey();
  TextEditingController vehicleNoController = TextEditingController();
  TextEditingController extraSimController = TextEditingController();
  TextEditingController remarksController = TextEditingController();
  late CheckOutBloc checkOutBloc; // Declare CheckOutBloc variable
  // late SimListBloc simListBloc; // Declare CheckOutBloc variable
  late RemoveDeviceBloc removeDeviceBloc;
  List<CameraDescription>? cameras;
  // CameraController? controller;

  // String? selectedSim;
  // List<String> simNumbers = ['Select Sim no'];

  Future<void> initCamera() async {
    cameras = await availableCameras();
    // controller = CameraController(
    //   cameras![1], // Select a camera from the list of available cameras.
    //   ResolutionPreset.medium,
    // );
    // await controller?.initialize();
    // Now you can use the controller for taking pictures.

    // await takePicture(controller!);
  }

  @override
  void initState() {
    super.initState();
    // Initialize the CheckOutBloc here
    // Modify this according to your CheckOutBloc initialization logic
    checkOutBloc = CheckOutBloc();
    // // simListBloc = SimListBloc();
    removeDeviceBloc = RemoveDeviceBloc();
    // BlocProvider.of<SimListBloc>(context).add(GetSimList(agentId: "0"));

    initCamera();
    // Call the checkout event after the widget is built
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   // Prepare the request string here
    //   GetSimList event = GetSimList(agentId: '0');
    //   simListBloc.add(event);
    //   simListBloc.add(GetSimList(agentId: '0'));
    // });
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    // simListBloc.add(GetSimList(agentId: '0'));

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    checkOutBloc.close(); // Close the bloc when disposing the screen
    removeDeviceBloc.close();
    // controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: const CustomAppBar(heading: 'DEVICE CHECK OUT'),
      body: MultiBlocProvider(
        providers: [
          BlocProvider<CheckOutBloc>(
            create: (context) => CheckOutBloc(), // Initialize CheckOutBloc here
          ),
          BlocProvider<RemoveDeviceBloc>(
            create: (context) =>
                RemoveDeviceBloc(), // Initialize RemoveDeviceBloc here
          ),
        ],
        child: MultiBlocListener(listeners: [
          BlocListener<CheckOutBloc, CheckOutState>(
            listener: (context, state) {
              if (state is CheckOutLoaded) {
                customToast(
                  message: "${state.message}",
                  color: Colors.green,
                );
                Navigator.pop(context);
                Navigator.pop(context);
                // Navigator.pop(context);
              } else if (state is CheckOutImageUploaded) {
                // // Call API of bloc
                // // Get the current system date and time
                // DateTime currentDateTime = DateTime.now();

                // // Create a date format
                // DateFormat dateFormat = DateFormat('yyyy-MM-dd HH:mm:ss');

                // // Format the DateTime object
                // String formattedDateTime = dateFormat.format(currentDateTime);

                // // p the formatted date and time
                // p('Formatted Date Time: $formattedDateTime');

                // // Convert formatted date string back to a DateTime object
                // DateTime parsedDateTime = dateFormat.parse(formattedDateTime);

                // JobInstallationData jobInstallationData = JobInstallationData();
                // jobInstallationData.installerId =
                //     widget.deviceListDetailsModel.userId ?? 0;
                // jobInstallationData.clientId =
                //     widget.deviceListDetailsModel.clientId ?? 0;
                // jobInstallationData.vehicleId =
                //     widget.deviceListDetailsModel.vehicleId ?? 0;
                // jobInstallationData.unitId =
                //     widget.deviceListDetailsModel.unitId ?? 0;
                // jobInstallationData.statusId = 7;
                // jobInstallationData.isActive = 1;
                // jobInstallationData.createdUserId =
                //     widget.deviceListDetailsModel.userId ?? 0;
                // jobInstallationData.modifiedUserId = 0;
                // jobInstallationData.agentId = 0;
                // jobInstallationData.image1 = "";
                // jobInstallationData.image2 = "";
                // jobInstallationData.image3 = "";
                // jobInstallationData.image4 = "";
                // jobInstallationData.image5 = "";
                // jobInstallationData.image6 = "";
                // jobInstallationData.signatureImage = "";
                // jobInstallationData.jobid = widget.jobDetails.jobId ?? 0;
                // if (vehicleNoController.text.isEmpty) {
                //   jobInstallationData.vehicleno =
                //       widget.deviceListDetailsModel.vehicleNo ?? "";
                // } else {
                //   jobInstallationData.vehicleno = vehicleNoController.text;
                // }
                // jobInstallationData.simNo =
                //     widget.deviceListDetailsModel.mobileNo ?? "";
                // if (extraSimController.text.isEmpty) {
                //   jobInstallationData.newSimNo =
                //       widget.deviceListDetailsModel.mobileNo ?? "";
                // } else {
                //   jobInstallationData.newSimNo = extraSimController.text;
                // }
                // if (remarksController.text.isEmpty) {
                //   jobInstallationData.remarks = "Old vehicle and sim";
                // } else {
                //   jobInstallationData.remarks = remarksController.text;
                // }
                // jobInstallationData.installationDate = parsedDateTime;
                // jobInstallationData.acceptedDateTime = parsedDateTime;
                // jobInstallationData.enrouteDateTime = parsedDateTime;
                // jobInstallationData.checkinDateTime = parsedDateTime;
                // jobInstallationData.checkoutDateTime = parsedDateTime;
                // jobInstallationData.completedDateTime = parsedDateTime;
                // jobInstallationData.declinedDateTime = parsedDateTime;
                // // jobInstallationData.oldunit = 0;
                // jobInstallationData.oldunit =
                //     widget.deviceListDetailsModel.unitId ?? 0;
                // String requestString = jobInstallationData.toJsonString();
                // CheckOutEvent event =
                //     DoCheckOut(requestString: requestString, requestType: 0);
                // checkOutBloc.add(event);
              } else if (state is CheckOutError) {
                customToast(
                  message: "Device checkout failed: ${state.errorMessage}",
                  color: Colors.red,
                );
              }
            },
          ),
          BlocListener<RemoveDeviceBloc, RemoveDeviceState>(
            listener: (context, state) {
              if (state is RemoveDeviceLoaded) {
                customToast(
                  message:
                      "Device removed successfully for job id ${widget.jobDetails.jobId}.",
                  color: Colors.green,
                );
                Navigator.pop(context); // Optionally pop the dialog or screen
                Navigator.pop(context);
                Navigator.pop(context);
              } else if (state is RemoveDeviceError) {
                customToast(
                  message: "Failed to remove device: ${state.errorMessage}",
                  color: Colors.red,
                );
              }
            },
          ),
        ], child: _buildUI(context)
            // ??
            //     BlocBuilder<CheckOutBloc, CheckOutState>(
            //       builder: (context, state) {
            //         return _buildUI(context, state); // Call a method to build UI
            //       },
            //     ),
            ),
      ),
    );
  }

  // Future<XFile?> takePicture(CameraController controller) async {
  //   if (!controller.value.isInitialized) {
  //     p('Controller is not initialized');
  //     return null;
  //   }

  //   if (controller.value.isTakingPicture) {
  //     p('Controller is taking picture');
  //     // A capture is already pending, do not take another
  //     return null;
  //   }
  //   p('Caputring while opening camera');
  //   try {
  //     final XFile file = await controller.takePicture();
  //     return file;
  //   } catch (e) {
  //     p('Error occurred while taking picture: $e');
  //     return null;
  //   }
  // }

  // Future<void> pickCameraImageSelector(BuildContext context) async {
  //   await Future.delayed(const Duration(
  //       milliseconds: 500)); // short delay before opening the picker

  //   // Check permission before opening the picker
  //   var cameraStatus = await Permission.camera.status;
  //   if (!cameraStatus.isGranted) {
  //     cameraStatus = await Permission.camera.request();
  //   }

  //   if (cameraStatus.isGranted) {
  //     try {
  //       final ImagePicker picker = ImagePicker();
  //       final XFile? image = await picker.pickImage(
  //           source: ImageSource.camera, imageQuality: 90);

  //       if (image != null) {
  //         p('Image selected: ${image.path}');
  //         // Handle the selected image
  //       }
  //     } catch (e) {
  //       p('Failed to pick image: $e');
  //     }
  //   } else {
  //     // Handle permission denial
  //     p('Camera permission was denied');
  //   }
  // }

// Function to request camera permission
  Future<void> _requestCameraPermission() async {
    if (Platform.isAndroid) {
      PermissionStatus status = await Permission.camera.request();
      final ImagePicker imagePicker = ImagePicker();
      // Check if permission is granted
      if (status.isGranted) {
        p('Permission is Granted');
        // WidgetsBinding.instance.addPostFrameCallback((_) async {
        if (!mounted) return;
        FocusScope.of(context).unfocus();
        final XFile? image =
            await imagePicker.pickImage(source: ImageSource.camera);

        p('Selecting Source camera');
        if (image != null) {
          p('Image is null');
          listOfImages.add(image.path);
          List<int> imageBytes = await image.readAsBytes();

          Uint8List uint8List = Uint8List.fromList(imageBytes);
          // Compress the image bytes
          var compressedBytes = await FlutterImageCompress.compressWithList(
            uint8List,
            quality: 15, // Adjust quality (0-100)
          );
          // Convert to Base64
          String base64Image = base64Encode(compressedBytes);
          p('Base64 Image: ${base64Image.length}');
          listOfBaseImages.add(base64Image);

          setState(() {});
        }
        // });
      } else if (status.isDenied) {
        // Permission denied
        p('Permission denied');
        // You might want to inform the user why the permission is necessary
      } else if (status.isPermanentlyDenied) {
        p('Open App Setting');
        // Permission permanently denied, navigate to app settings
        openAppSettings();
      } else {
        if (!mounted) return;
        FocusScope.of(context).unfocus();
        final XFile? image =
            await imagePicker.pickImage(source: ImageSource.camera);

        p('Selecting Source camera');
        if (image != null) {
          p('Image is null');
          listOfImages.add(image.path);
          // Read the image file as bytes
          // List<int> imageBytes = await image.readAsBytes();
          // // Encode the bytes to base64
          // String base64Image = base64Encode(imageBytes);
          // listOfBaseImages.add(base64Image);

          List<int> imageBytes = await image.readAsBytes();

          Uint8List uint8List = Uint8List.fromList(imageBytes);
          // Compress the image bytes
          var compressedBytes = await FlutterImageCompress.compressWithList(
            uint8List,
            quality: 15, // Adjust quality (0-100)
          );
          // Convert to Base64
          String base64Image = base64Encode(compressedBytes);
          print('Base64 Image: ${base64Image.length}');
          listOfBaseImages.add(base64Image);
          setState(() {});
        }
        if (!mounted) return;
        Navigator.pop(context);
      }
    }
  }

  //! Dailog for adding images
  Future<void> _showImagePickerModal() async {
    // final ImagePicker imagePicker = ImagePicker();
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bottomContext) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 14, top: 8),
              child: Text(
                "Select option",
                style: TextStyles.title2(
                  context: context,
                ),
              ),
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: () async {
                    if (listOfImages.length < 6) {
                      _requestCameraPermission();
                    } else {
                      FocusScope.of(context).unfocus();
                      customToast(
                        message: "Maximum 6 images can be uploaded",
                        color: Colors.red,
                      );
                    }
                  },
                  child: Container(
                    margin: const EdgeInsets.all(14),
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: ColorsPlatte.primaryColor,
                        ),
                        borderRadius: BorderRadius.circular(
                          8,
                        )),
                    child: const Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.camera_alt_outlined,
                          size: 38,
                          color: Colors.black,
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          "Camera",
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    if (listOfImages.length < 6) {
                      pickImages();
                      Navigator.pop(context);
                    } else {
                      FocusScope.of(context).unfocus();
                      customToast(
                        message: "Maximum 6 images can be uploaded",
                        color: Colors.red,
                      );
                    }
                    // _pickImage(imagePicker);
                  },
                  child: Container(
                    margin: const EdgeInsets.all(14),
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: ColorsPlatte.primaryColor,
                        ),
                        borderRadius: BorderRadius.circular(
                          8,
                        )),
                    child: const Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 6),
                          child: Icon(
                            Icons.photo_camera_back_outlined,
                            size: 38,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          "Gallery",
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  bool _handleOnDrawStart() {
    _isSigned = true;
    return false;
  }

  void pickImages() async {
    // Set your maximum selection limit here
    int maxSelection = 6 - listOfBaseImages.length;
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: true, // Allow multiple file selection
    );

    if (result != null) {
      // Check if the widget is still in the widget tree
      if (!mounted) return;
      FocusScope.of(context).unfocus();

      // Check if the number of selected files exceeds the maximum limit
      if (result.files.length > maxSelection) {
        // Show an alert or message to the user
        p('********* You can only select up to $maxSelection images.');

        customToast(
          message: 'You can only select up to $maxSelection images.',
          color: Colors.red,
        );
        return; // Exit the function if the limit is exceeded
      }

      p('********* Processing selected files from gallery');

      // Iterate through selected files
      for (var file in result.files) {
        if (file.path != null && file.path!.isNotEmpty) {
          p('********* File exists: ${file.path}');

          // Create an XFile object
          XFile imageFile = XFile(file.path!);

          // Read the image file as bytes
          // List<int> imageBytes1 = await imageFile.readAsBytes();
          // // Encode the bytes to base64
          // String base64Image = base64Encode(imageBytes1);
          // print('Base64 Image1 : ${base64Image.length}');
          // listOfBaseImages.add(base64Image);
          listOfImages.add(imageFile.path);

          List<int> imageBytes = await imageFile.readAsBytes();

          Uint8List uint8List = Uint8List.fromList(imageBytes);
          // Compress the image bytes
          var compressedBytes = await FlutterImageCompress.compressWithList(
            uint8List,
            quality: 15, // Adjust quality (0-100)
          );
          // Convert to Base64
          String base64Image1 = base64Encode(compressedBytes);
          print('Base64 Image2 : ${base64Image1.length}');
          listOfBaseImages.add(base64Image1);
          // Update the UI

          setState(() {});
        } else {
          p('********* No file found for one of the selected files');
        }
      }
    } else {
      // User canceled the picker
      p('********* User canceled the file picker');
    }
  }

  // void pickImage() async {
  //   FilePickerResult? result = await FilePicker.platform.pickFiles(
  //     type: FileType.image,
  //   );

  //   if (result != null) {
  //     if (!mounted) return;
  //     // File file = File(result.files.single.path!);
  //     FocusScope.of(context).unfocus();

  //     // Use the file
  //     XFile imageFile = XFile(result.files.single.path!);

  //     p('Processing existing file from gallery');

  //     if (imageFile.path.isNotEmpty) {
  //       p('File exists');

  //       // Read the image file as bytes
  //       // List<int> imageBytes = await imageFile.readAsBytes();

  //       // // Encode the bytes to base64
  //       // String base64Image = base64Encode(imageBytes);
  //       // listOfBaseImages.add(base64Image);
  //       // listOfImages.add(imageFile.path);
  //       List<int> imageBytes = await imageFile.readAsBytes();

  //       Uint8List uint8List = Uint8List.fromList(imageBytes);
  //       // Compress the image bytes
  //       var compressedBytes = await FlutterImageCompress.compressWithList(
  //         uint8List,
  //         quality: 15, // Adjust quality (0-100)
  //       );
  //       // Convert to Base64
  //       String base64Image1 = base64Encode(compressedBytes);
  //       print('Base64 Image2 : ${base64Image1.length}');
  //       listOfBaseImages.add(base64Image1);
  //       // Update the UI
  //       setState(() {});
  //     } else {
  //       p('No file found');
  //     }
  //   } else {
  //     // User canceled the picker
  //   }
  // }

  void _removeImage(int index) {
    if (index >= 0 &&
        index < listOfImages.length &&
        index < listOfBaseImages.length) {
      setState(() {
        listOfImages.removeAt(index);
        listOfBaseImages.removeAt(index);
      });
      customToast(
        message: "Image removed successfully",
        color: Colors.green,
      );
    }
  }

  void _showPopup() {
    // Don't clear signature data - keep existing signature for editing
    _isSigned = _signatureData.isNotEmpty;

    showDialog<Widget>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder:
              (BuildContext context, void Function(void Function()) setState) {
            return ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: AlertDialog(
                  insetPadding: const EdgeInsets.all(12),
                  backgroundColor: Colors.white,
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      const Text('Draw your signature',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Roboto-Medium')),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                          // Navigator.of(context).pop();
                        },
                        child: const Icon(Icons.clear,
                            color: Color.fromRGBO(0, 0, 0, 0.54), size: 24.0),
                      )
                    ],
                  ),
                  titlePadding: const EdgeInsets.all(16.0),
                  content: SingleChildScrollView(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width < 306
                          ? MediaQuery.of(context).size.width
                          : 450,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width < 306
                                ? MediaQuery.of(context).size.width
                                : 450,
                            height: 172,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                            ),
                            child: Stack(
                              children: [
                                // Show existing signature as background if available
                                if (_signatureData.isNotEmpty)
                                  Positioned.fill(
                                    child: Image.memory(
                                      _signatureData,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                // Signature pad on top
                                SfSignaturePad(
                                    minimumStrokeWidth: 1,
                                    maximumStrokeWidth: 4,
                                    strokeColor: Colors.black,
                                    backgroundColor: Colors.transparent,
                                    onDrawStart: _handleOnDrawStart,
                                    key: _signaturePadKey),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12.0),
                  actionsPadding: const EdgeInsets.all(8.0),
                  buttonPadding: EdgeInsets.zero,
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        _handleClearButtonPressed(setState);
                      },
                      style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.all(Colors.red),
                        // WidgetStateProperty.all<Color>(Colors.red),
                      ),
                      child: const Text(
                        'CLEAR',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Roboto-Medium'),
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    TextButton(
                      onPressed: () {
                        _handleSaveButtonPressed();
                        Navigator.pop(context);
                        // Navigator.of(context).pop();
                      },
                      style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.all(
                            ColorsPlatte.primaryColor),
                        // WidgetStateProperty.all<Color>(
                        //     ColorsPlatte.primaryColor),
                      ),
                      child: const Text('SAVE',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Roboto-Medium')),
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Future<void> _handleSaveButtonPressed() async {
    // Check if there's actually a signature drawn
    if (!_isSigned) {
      // No signature drawn, clear any existing signature
      _signatureData = Uint8List(0);
      if (listOfBaseImages.length > 6) {
        listOfBaseImages.removeAt(6);
      }
      setState(() {
        _isSigned = false;
      });
      return;
    }

    late Uint8List data;

    final ui.Image imageData =
        await _signaturePadKey.currentState!.toImage(pixelRatio: 3.0);

    // Create a white background canvas
    final ui.PictureRecorder recorder = ui.PictureRecorder();
    final ui.Canvas canvas = ui.Canvas(recorder);

    // Fill with white background
    canvas.drawRect(
      Rect.fromLTWH(
          0, 0, imageData.width.toDouble(), imageData.height.toDouble()),
      ui.Paint()..color = Colors.white,
    );

    // Draw the signature on top of white background
    canvas.drawImage(imageData, Offset.zero, ui.Paint());

    final ui.Picture picture = recorder.endRecording();
    final ui.Image finalImage = await picture.toImage(
      imageData.width,
      imageData.height,
    );

    final ByteData? bytes =
        await finalImage.toByteData(format: ui.ImageByteFormat.png);
    if (bytes != null) {
      data = bytes.buffer.asUint8List();
    }

    // Compress the image bytes
    var compressedBytes = await FlutterImageCompress.compressWithList(
      data,
      quality: 15, // Adjust quality (0-100)
    );
    // Convert to Base64
    String base64Image = base64Encode(compressedBytes);
    p('Base64 Image: ${base64Image.length}');

    // Update or add signature to listOfBaseImages
    if (listOfBaseImages.length > 6) {
      // Replace existing signature (7th item)
      listOfBaseImages[6] = base64Image;
    } else {
      // Add new signature (7th item after 6 images)
      listOfBaseImages.add(base64Image);
    }

    setState(
      () {
        _signatureData = data;
        _isSigned = true;
      },
    );
  }

  void _handleClearButtonPressed(
      void Function(void Function()) dialogSetState) {
    _signaturePadKey.currentState!.clear();
    _isSigned = false;
    // Clear signature data from memory
    _signatureData = Uint8List(0);
    // Remove signature from listOfBaseImages if it exists
    if (listOfBaseImages.isNotEmpty && listOfBaseImages.length > 6) {
      listOfBaseImages.removeLast();
    }
    // Update both the dialog state and main widget state
    dialogSetState(() {});
    setState(() {});
  }

  Widget _buildUI(
    BuildContext context,
  ) {
    final size = MediaQuery.sizeOf(context);
    return BlocBuilder<CheckOutBloc, CheckOutState>(builder: (context, state) {
      return Stack(
        children: [
          Column(
            children: [
              Expanded(
                flex: 8,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 14,
                        ),
                        Container(
                          margin: const EdgeInsets.all(8),
                          width: size.width,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: ColorsPlatte.primaryColor,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(4),
                                width: size.width,
                                decoration: const BoxDecoration(
                                  color: ColorsPlatte.primaryColor,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(6),
                                    topRight: Radius.circular(6),
                                  ),
                                ),
                                child: Text(
                                  "Job details",
                                  style: TextStyles.title2(
                                    context: context,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    JobDetailsCard2EntityWidget(
                                      title: "Client Name:",
                                      value: widget.jobDetails.clientName!,
                                    ),
                                    JobDetailsCard2EntityWidget(
                                      title: "Unit Number:",
                                      value:
                                          widget.deviceListDetailsModel.unitNo!,
                                    ),
                                    JobDetailsCard2EntityWidget(
                                      title: "Sim Number:",
                                      value: widget
                                          .deviceListDetailsModel.mobileNo!,
                                    ),
                                    JobDetailsCard2EntityWidget(
                                      title: "Location",
                                      value: widget.jobDetails.jobLocation!,
                                    ),
                                    Text(
                                      "Purpose",
                                      style: TextStyles.title2(
                                        context: context,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    Text(
                                      widget.jobDetails.purposeOfVisit!,
                                      style: TextStyles.subTitle1(
                                        context: context,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    Divider(
                                      color: ColorsPlatte.primaryColor
                                          .withOpacity(0.5),
                                    ),
                                    const SizedBox(
                                      height: 6,
                                    ),
                                    widget.jobDetails.purposeOfVisitId == 5
                                        ? Container()
                                        : Text(
                                            "Vehicle No",
                                            style: TextStyles.title2(
                                              context: context,
                                            ),
                                          ),
                                    widget.jobDetails.purposeOfVisitId == 5
                                        ? Container()
                                        : TextFormField(
                                            controller: vehicleNoController,
                                            maxLength: 30,
                                            decoration: const InputDecoration(
                                              hintText: 'Enter vehicle no',
                                            ),
                                          ),
                                    widget.jobDetails.purposeOfVisitId == 5
                                        ? Container()
                                        : const SizedBox(
                                            height: 2,
                                          ),
                                    // widget.jobDetails.purposeOfVisitId == 5
                                    //     ? Container()
                                    //     : BlocBuilder<SimListBloc,
                                    //         SimListState>(
                                    //         builder: (context, simState) {
                                    //           p("State == ${simState.runtimeType}");
                                    //           if (simState is SimListLoading) {
                                    //             return const CircularProgressIndicator();
                                    //           }
                                    //           if (simState is GetSimLoaded) {
                                    //             p('GetSimLoaded is called');
                                    //             simNumbers =
                                    //                 simState.simNumbers;

                                    //             simNumbers.insert(
                                    //                 0, 'Select Sim no');

                                    //             return Column(
                                    //               crossAxisAlignment:
                                    //                   CrossAxisAlignment.start,
                                    //               children: [
                                    //                 Text(
                                    //                   "SIM No",
                                    //                   style: TextStyles.title2(
                                    //                     context: context,
                                    //                   ),
                                    //                 ),
                                    //                 DropdownButtonFormField<
                                    //                     String>(
                                    //                   value: selectedSim,
                                    //                   decoration:
                                    //                       const InputDecoration(
                                    //                     hintText:
                                    //                         'Select Sim no',
                                    //                   ),
                                    //                   items: simNumbers.map(
                                    //                       (String simNumber) {
                                    //                     return DropdownMenuItem<
                                    //                         String>(
                                    //                       value: simNumber,
                                    //                       child:
                                    //                           Text(simNumber),
                                    //                     );
                                    //                   }).toList(),
                                    //                   onChanged:
                                    //                       (String? newValue) {
                                    //                     selectedSim = newValue!;
                                    //                   },
                                    //                 ),
                                    //               ],
                                    //             );
                                    //           }
                                    //           if (simState is SimListError) {
                                    //             return Text(
                                    //                 "Error: ${simState.errorMessage}");
                                    //           }
                                    //           return const SizedBox.shrink();
                                    //         },
                                    //       ),
                                    // widget.jobDetails.purposeOfVisitId == 5
                                    //     ? Container()
                                    //     : const SizedBox(
                                    //         height: 2,
                                    //       ),
                                    // widget.jobDetails.purposeOfVisitId == 5
                                    //     ? Container()
                                    //     : Text(
                                    //         "Remarks",
                                    //         style: TextStyles.title2(
                                    //           context: context,
                                    //         ),
                                    //       ),
                                    // widget.jobDetails.purposeOfVisitId == 5
                                    //     ? Container()
                                    //     : TextFormField(
                                    //         maxLength: 120,
                                    //         controller: remarksController,
                                    //         decoration: const InputDecoration(
                                    //           hintText: 'Enter remarks no',
                                    //         ),
                                    //       ),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 14,
                        ),
                        //! Add remarks
                        Container(
                          margin: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: ColorsPlatte.primaryColor,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: const BoxDecoration(
                                  color: ColorsPlatte.primaryColor,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(6),
                                    topRight: Radius.circular(6),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "Add remarks",
                                          style: TextStyles.title2(
                                            context: context,
                                            color: Colors.white,
                                          ),
                                        ),
                                        const SizedBox(width: 4),
                                        const CustomIcon(
                                          iconName: 'ic_pen.png',
                                          height: 20,
                                          width: 20,
                                          color: Colors.white,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextField(
                                  controller: remarksController,
                                  maxLines: 3,
                                  decoration: const InputDecoration(
                                    hintText: 'Enter your remarks here...',
                                    border: OutlineInputBorder(),
                                    contentPadding: EdgeInsets.all(12),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        //! Add Images
                        Container(
                          margin: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: ColorsPlatte.primaryColor,
                            ),
                            borderRadius: BorderRadius.circular(
                              8,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: const BoxDecoration(
                                  color: ColorsPlatte.primaryColor,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(
                                      6,
                                    ),
                                    topRight: Radius.circular(6),
                                  ),
                                ),
                                child: GestureDetector(
                                  onTap: () async {
                                    _showImagePickerModal();
                                    // await pickCameraImageSelector(context);

                                    // await takePicture(controller!);
                                    // } else {
                                    //   customToast(
                                    //       message: "Maximum 6 images can be uploaded",
                                    //       color: Colors.red.shade500);
                                  },
                                  child: Row(
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "Add Images",
                                            style: TextStyles.title2(
                                              context: context,
                                              color: Colors.white,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 4,
                                          ),
                                          const CustomIcon(
                                            iconName: 'ic_gallery.png',
                                            height: 20,
                                            width: 20,
                                            color: Colors.white,
                                          ),
                                        ],
                                      ),
                                      const Spacer(),
                                      const Icon(
                                        Icons.add_circle_outline,
                                        size: 28,
                                        color: Colors.white,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              listOfImages.isNotEmpty
                                  ? Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: SizedBox(
                                          height: listOfImages.length > 3
                                              ? 240
                                              : 120,
                                          child: GridView.builder(
                                            gridDelegate:
                                                const SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 3,
                                            ),
                                            itemCount: listOfImages.length,
                                            itemBuilder: (context, index) {
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Stack(
                                                  children: [
                                                    SizedBox(
                                                      height: 80,
                                                      width: 100,
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                        child: Image.file(
                                                          File(
                                                            listOfImages[index],
                                                          ),
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    ),
                                                    // Remove button overlay
                                                    Positioned(
                                                      top: 4,
                                                      right: 4,
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          _removeImage(index);
                                                        },
                                                        child: Container(
                                                          decoration:
                                                              const BoxDecoration(
                                                            color: Colors.red,
                                                            shape:
                                                                BoxShape.circle,
                                                          ),
                                                          child: const Icon(
                                                            Icons.close,
                                                            color: Colors.white,
                                                            size: 16,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                          )),
                                    )
                                  : Container(),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        //!Add Signature
                        Container(
                          margin: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: ColorsPlatte.primaryColor,
                            ),
                            borderRadius: BorderRadius.circular(
                              8,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: const BoxDecoration(
                                  color: ColorsPlatte.primaryColor,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(
                                      6,
                                    ),
                                    topRight: Radius.circular(6),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Text(
                                      "Signature",
                                      style: TextStyles.title2(
                                          context: context,
                                          color: Colors.white),
                                    ),
                                    const SizedBox(
                                      width: 4,
                                    ),
                                    const CustomIcon(
                                      iconName: 'ic_signature.png',
                                      height: 20,
                                      width: 20,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              GestureDetector(
                                onTap: () {
                                  if (listOfBaseImages.isNotEmpty &&
                                      listOfBaseImages.length > 5) {
                                    // Show signature dialog with current signature pre-loaded
                                    _showPopup();
                                  } else {
                                    customToast(
                                      message:
                                          "Please capture six images to proceed further.",
                                      color: Colors.red,
                                    );
                                  }
                                },
                                child: Container(
                                  height: 80,
                                  width: size.width * 0.5,
                                  margin: const EdgeInsets.all(14),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: ColorsPlatte.primaryColor,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: _isSigned
                                      ? Image.memory(_signatureData)
                                      : const Center(
                                          child: Text("Tap here to sign"),
                                        ),
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomButton(
                        buttonColor: ColorsPlatte.customRedColor,
                        innerText: "REMOVE DEVICE",
                        onPressed: () {
                          if (state is CheckOutLoading) {
                            return;
                          }
                          // Navigator.pop(context);
                          removeDialog(
                              context,
                              // checkOutBloc,
                              widget.deviceListDetailsModel,
                              widget
                                  .jobDetails); // Pass the CheckOutBloc to the dialog
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomButton(
                        buttonColor: ColorsPlatte.customGreenColor,
                        innerText: "DEVICE CHECKOUT",
                        onPressed: () {
                          if (widget.jobDetails.purposeOfVisitId == 5) {
                            // For purpose 5, we already have vehicle number, just check images and signature
                            if (listOfBaseImages.isNotEmpty &&
                                listOfBaseImages.length > 5 &&
                                _signatureData.length > 0) {
                              for (var base in listOfBaseImages) {
                                p('BASE: $base');
                              }
                              p('State of checkout: ${state.runtimeType}');
                              if (state is CheckOutLoading) {
                                return;
                              }
                              checkoutDialog(
                                  context,
                                  // checkOutBloc,
                                  widget.deviceListDetailsModel,
                                  widget.jobDetails);
                            } else {
                              customToast(
                                message:
                                    "Please capture six images with signature to proceed further.",
                                color: Colors.red,
                              );
                            }
                          } else if (widget.jobDetails.purposeOfVisitId == 8 ||
                              widget.jobDetails.purposeOfVisitId == 6) {
                            // For purpose 8 and 6, check vehicle number, images and signature
                            if (vehicleNoController.text.isNotEmpty ||
                                vehicleNoController.text != "") {
                              if (vehicleNoController.text.length > 5) {
                                if (listOfBaseImages.isNotEmpty &&
                                    listOfBaseImages.length > 5 &&
                                    _signatureData.length > 0) {
                                  for (var base in listOfBaseImages) {
                                    p('BASE: $base');
                                  }
                                  p('State of checkout: ${state.runtimeType}');
                                  if (state is CheckOutLoading) {
                                    return;
                                  }
                                  checkoutDialog(
                                      context,
                                      // checkOutBloc,
                                      widget.deviceListDetailsModel,
                                      widget.jobDetails);
                                } else {
                                  customToast(
                                    message:
                                        "Please capture six images with signature to proceed further.",
                                    color: Colors.red,
                                  );
                                }
                              } else {
                                customToast(
                                  message: "Please enter proper vehicle number",
                                  color: Colors.red,
                                );
                              }
                            } else {
                              customToast(
                                message:
                                    "Please enter vehicle number to proceed further.",
                                color: Colors.red,
                              );
                            }
                          } else {
                            // For other purposes, no special requirements
                            if (state is CheckOutLoading) {
                              return;
                            }
                            checkoutDialog(
                                context,
                                // checkOutBloc,
                                widget.deviceListDetailsModel,
                                widget.jobDetails);
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          if (state is CheckOutLoading)
            const SizedBox(
              height: 250,
              child: Center(child: CircularProgressIndicator()),
            ),
        ],
      );
    });
  }

  void checkoutDialog(
      BuildContext context,
      DeviceListDetailsModel deviceListDetailsModel,
      JobListDetailsModel jobDetails) {
    checkOutBloc = BlocProvider.of<CheckOutBloc>(context);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder:
              (BuildContext context, void Function(void Function()) setState) {
            return AlertDialog(
              title: const Text('Checkout Confirmation'),
              content: const Text('Are you sure you want to checkout?'),
              actions: <Widget>[
                TextButton(
                  child: const Text('Cancel'),
                  onPressed: () {
                    Navigator.pop(context);
                    // Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: const Text('Checkout'),
                  onPressed: () async {
                    // Check if all conditions are met to proceed with checkout

                    // p('${deviceListDetailsModel.clientId ?? 0}');
                    // p('${deviceListDetailsModel.userId ?? 0}');
                    // p('${deviceListDetailsModel.unitId ?? 0}');
                    // p('${deviceListDetailsModel.unitNo}');
                    // p('${deviceListDetailsModel.vehicleId ?? 0}');
                    // p('length of image 1: ${listOfBaseImages[0].length}');
                    // p('length of image 2: ${listOfBaseImages[1].length}');
                    // p('length of image 3: ${listOfBaseImages[2].length}');
                    // p('length of image 4: ${listOfBaseImages[3].length}');
                    // p('length of image 5: ${listOfBaseImages[4].length}');
                    // p('length of image 6: ${listOfBaseImages[5].length}');
                    // p('${deviceListDetailsModel.jobId ?? 0}');
                    // JobImageData jobImageData = JobImageData();
                    // jobImageData.jobid = jobDetails.jobId ?? 0;
                    // jobImageData.clientId =
                    //     deviceListDetailsModel.clientId ?? 0;
                    // jobImageData.image1 = listOfBaseImages[0];
                    // jobImageData.image2 = listOfBaseImages[1];
                    // jobImageData.image3 = listOfBaseImages[2];
                    // jobImageData.image4 = listOfBaseImages[3];
                    // jobImageData.image5 = listOfBaseImages[4];
                    // jobImageData.image6 = listOfBaseImages[5];
                    // jobImageData.signatureImage = "";
                    // String requestImageString = jobImageData.toJsonString();
                    // CheckOutEvent imageEvent = DoCheckOut(
                    //     requestString: requestImageString, requestType: 1);
                    // // Execute both uploads concurrently
                    // checkOutBloc.add(imageEvent);
                    // // checkOutBloc.add(event);
                    // // Navigator.of(context).pop();
                    Navigator.pop(context);

                    // Call API of bloc
                    // Get the current system date and time
                    DateTime currentDateTime = DateTime.now();

                    // Create a date format
                    DateFormat dateFormat = DateFormat('yyyy-MM-dd HH:mm:ss');

                    // Format the DateTime object
                    String formattedDateTime =
                        dateFormat.format(currentDateTime);

                    // p the formatted date and time
                    p('Formatted Date Time: $formattedDateTime');

                    // Convert formatted date string back to a DateTime object
                    DateTime parsedDateTime =
                        dateFormat.parse(formattedDateTime);

                    JobInstallationData jobInstallationData =
                        JobInstallationData();

                    jobInstallationData.installerId =
                        widget.deviceListDetailsModel.userId ?? 0;
                    jobInstallationData.clientId =
                        widget.deviceListDetailsModel.clientId ?? 0;
                    jobInstallationData.vehicleId =
                        widget.deviceListDetailsModel.vehicleId ?? 0;
                    jobInstallationData.unitId =
                        widget.deviceListDetailsModel.unitId ?? 0;
                    jobInstallationData.statusId = 7;
                    jobInstallationData.isActive = 1;
                    jobInstallationData.createdUserId =
                        widget.deviceListDetailsModel.userId ?? 0;
                    jobInstallationData.modifiedUserId = 0;
                    jobInstallationData.agentId = 0;
                    jobInstallationData.image1 = listOfBaseImages[0];
                    jobInstallationData.image2 = listOfBaseImages[1];
                    jobInstallationData.image3 = listOfBaseImages[2];
                    jobInstallationData.image4 = listOfBaseImages[3];
                    jobInstallationData.image5 = listOfBaseImages[4];
                    jobInstallationData.image6 = listOfBaseImages[5];
                    jobInstallationData.signatureImage =
                        base64Encode(_signatureData);
                    jobInstallationData.jobid = widget.jobDetails.jobId ?? 0;
                    if (vehicleNoController.text.isEmpty) {
                      jobInstallationData.vehicleno =
                          widget.deviceListDetailsModel.vehicleNo ?? "";
                    } else {
                      jobInstallationData.vehicleno = vehicleNoController.text;
                    }
                    jobInstallationData.simNo =
                        widget.deviceListDetailsModel.mobileNo ?? "";

                    // NewSimNo is not used in the API
                    // if (extraSimController.text.isEmpty) {
                    //   jobInstallationData.newSimNo =
                    //       widget.deviceListDetailsModel.mobileNo ?? "";
                    // } else {
                    //   jobInstallationData.newSimNo = extraSimController.text;
                    // }

                    if (remarksController.text.isEmpty) {
                      jobInstallationData.remarks = "NO REMARKS";
                    } else {
                      jobInstallationData.remarks = remarksController.text;
                    }
                    jobInstallationData.installationDate = parsedDateTime;
                    jobInstallationData.acceptedDateTime = parsedDateTime;
                    jobInstallationData.enrouteDateTime = parsedDateTime;
                    jobInstallationData.checkinDateTime = parsedDateTime;
                    jobInstallationData.checkoutDateTime = parsedDateTime;
                    jobInstallationData.completedDateTime = parsedDateTime;
                    jobInstallationData.declinedDateTime = parsedDateTime;
                    // jobInstallationData.oldunit = 0;
                    jobInstallationData.oldunit =
                        widget.deviceListDetailsModel.unitId ?? 0;
                    // Use minimal payload for JobUnitUpdate to avoid 500
                    String requestString = jobInstallationData
                        .toJsonStringMinimalForJobUnitUpdate();
                    logHttpRequest('POST', "checkout api", body: requestString);
                    CheckOutEvent event = DoCheckOut(
                        requestString: requestString, requestType: 0);
                    checkOutBloc.add(event);
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  void removeDialog(
      BuildContext context,
      DeviceListDetailsModel deviceListDetailsModel,
      JobListDetailsModel jobDetails) {
    removeDeviceBloc = BlocProvider.of<RemoveDeviceBloc>(context);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder:
              (BuildContext context, void Function(void Function()) setState) {
            return AlertDialog(
              title: const Text('Remove device'),
              content:
                  const Text('Are you sure you want to remove the device?'),
              actions: <Widget>[
                TextButton(
                  child: const Text('Cancel'),
                  onPressed: () {
                    Navigator.pop(context);
                    // Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: const Text('Remove'),
                  onPressed: () {
                    if (widget.deviceLenght > 1) {
                      p('${deviceListDetailsModel.unitId ?? 0}');
                      p('${deviceListDetailsModel.jobId ?? 0}');

                      RemoveDeviceData removeDeviceData = RemoveDeviceData();
                      removeDeviceData.unitId =
                          deviceListDetailsModel.unitId.toString();
                      removeDeviceData.jobid =
                          deviceListDetailsModel.jobId ?? 0;
                      String requestString = removeDeviceData.toJsonString();
                      RemoveDeviceEvent event =
                          RemoveDevice(requestString: requestString);
                      removeDeviceBloc.add(event);
                      // Navigator.of(context).pop();
                      Navigator.pop(context);
                    } else {
                      customToast(
                        message:
                            "At least one device must be present for the job.",
                        color: Colors.red,
                      );
                      Navigator.pop(context);
                    }
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }
}
