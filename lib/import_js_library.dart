import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_web_plugins/src/plugin_registry.dart';

import 'import_js_library_web.dart';

class ImportJsLibrary {
  static Future<void> import(String url) {
    if (kIsWeb)
      return ImportJsLibraryWeb.import(url);
    else
      return Future.value(null);
  }

  static bool isImported(String url) {
    if (kIsWeb) {
      return ImportJsLibraryWeb.isImported(url);
    } else {
      return false;
    }
  }

  static void registerWith(Registrar registrarFor) {
    //no-op
  }
}

String _libraryUrl(String url, String pluginName){
  if(url.startsWith("./")) {
    url = url.replaceFirst("./", "");
    return "./assets/packages/$pluginName/$url";
  }
  if(url.startsWith("assets/")) {
    return "./assets/packages/$pluginName/$url";
  } else {
    return url;
  }
}

void importJsLibrary({String url, String pluginName}) {
  if(pluginName == null) {
    ImportJsLibrary.import(url);
  } else if(assets.startsWith("./assets/") || assets.startsWith("assets/")){
    ImportJsLibrary.import(_libraryUrl(url, packageName));
  }
}

bool isJsLibraryImported(String url, {String pluginName}) {
  if(pluginName == null) {
    return ImportJsLibrary.isImported(url);
  } else {
    return ImportJsLibrary.isImported(_libraryUrl(url, packageName));
  }
}