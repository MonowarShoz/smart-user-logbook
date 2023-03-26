package com.example.technoart_monitoring;
import androidx.annotation.NonNull;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;



import android.os.Bundle;
import android.os.StrictMode;

import com.google.auth.oauth2.GoogleCredentials;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Arrays;

public class MainActivity extends FlutterActivity {
    public static final String CHANNEL = "samples.flutter.dev/getAccessToken";

    public static final String PROJECT_ID = "technoart-monitor";
    public static final String BASE_URL = "https://fcm.googleapis.com";
    public static final String FCM_SEND_ENDPOINT = "/v1/projects/" + PROJECT_ID + "/messages:send";

    public static final String MESSAGING_SCOPE = "https://www.googleapis.com/auth/firebase.messaging";
    public static final String[] SCOPES = { MESSAGING_SCOPE };

    public static final String TITLE = "FCM Notification";
    public static final String BODY = "Notification from FCM";
    public static final String MESSAGE_KEY = "message";

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);
        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
                .setMethodCallHandler(
                        (call, result) -> {
                            StrictMode.ThreadPolicy policy = new StrictMode.ThreadPolicy.Builder().permitAll().build();
                            StrictMode.setThreadPolicy(policy);
                            if (call.method.equals("getToken")){
                                try {
                                    String retrieveToken = getAccessToken();
                                    if(retrieveToken != null){
                                        result.success(retrieveToken);
                                    } else{
                                        result.error("UnaAvailable","Failed To get TOken",null);
                                    }
                                } catch (IOException e) {
                                    throw new RuntimeException(e);
                                }
                            } else {
                                result.notImplemented();
                                System.out.print("Operation Failed");
                            }

                        }
                );
    }


    public String getAccessToken() throws IOException {
        InputStream fis = getApplicationContext().getResources().openRawResource(getApplicationContext().getResources().getIdentifier("serviceaccount","raw",getPackageName()));

      
        GoogleCredentials googleCredentials = GoogleCredentials
                .fromStream(fis)
                .createScoped(Arrays.asList(SCOPES));
        googleCredentials.refreshAccessToken();
        return googleCredentials.getAccessToken().getTokenValue();
    }

}