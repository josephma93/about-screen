package com.github.josephma93.aboutscreen;

import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.CallbackContext;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import android.util.DisplayMetrics;
import java.lang.Math;


/**
 * This class echoes a string called from JavaScript.
 */
public class AboutScreen extends CordovaPlugin {

    private static final String ACTION_GET_INFO = "getInfo";


    @Override
    public boolean execute(String action, JSONArray args, CallbackContext callbackContext) throws JSONException {
        if (action.equals(ACTION_GET_INFO)) {
            this.getInfo(callbackContext);
            return true;
        }
        return false;
    }

    private void getInfo(CallbackContext callbackContext) {
        DisplayMetrics dm = new DisplayMetrics();
        (this.cordova.getActivity()).getWindowManager().getDefaultDisplay().getMetrics(dm);
        int width  =     dm.widthPixels;
        int height =     dm.heightPixels;
        int dens   =     dm.densityDpi;
        double wi  =     (double)width/(double)dens;
        double hi  =     (double)height/(double)dens;
        double x   =     Math.pow(wi,2);
        double y   =     Math.pow(hi,2);
        double screenDiagonal = Math.sqrt(x+y);
        JSONObject info = new JSONObject();
        try {
            info.put("width",width);
            info.put("height",height);
            info.put("density",dens);
            info.put("screenDiagonal",screenDiagonal);
        } catch (JSONException e) {
            callbackContext.error("Unexpected JSONException.");
            e.printStackTrace();
        }
        callbackContext.success(info);
    }
}