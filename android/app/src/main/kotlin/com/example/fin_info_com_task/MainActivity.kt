package com.example.fin_info_com_task


import android.Manifest
import android.bluetooth.BluetoothAdapter
import android.bluetooth.BluetoothManager
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.content.pm.PackageManager
import androidx.core.app.ActivityCompat
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {

    private val CHANNEL = "com.example.channel/bluetooth"
    private val METHOD_BLUETOOTH_ON = "BluetoothStateOn"
    private val METHOD_BLUETOOTH_OFF = "BluetoothStateOff"
    private val METHOD_STARTING_STATE = "startingState"

    private lateinit var channel: MethodChannel

    private lateinit var bluetoothManager: BluetoothManager
    private lateinit var bluetoothAdapter: BluetoothAdapter

    private var CURRENT_STATE = ""

    private lateinit var broadCast: MyBroadcastReceiver


    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        bluetoothManager = context.getSystemService(Context.BLUETOOTH_SERVICE) as BluetoothManager
        callBluetoothState()
    }

    private fun callBluetoothState() {
        bluetoothAdapter = bluetoothManager.adapter
        channel = MethodChannel(flutterEngine!!.dartExecutor.binaryMessenger, CHANNEL)
        channel.setMethodCallHandler { call, result ->
            when (call.method) {
                METHOD_BLUETOOTH_ON -> {
                    if (!bluetoothAdapter.isEnabled) {
                        if (ActivityCompat.checkSelfPermission(
                                this,
                                Manifest.permission.BLUETOOTH_CONNECT
                            ) != PackageManager.PERMISSION_GRANTED
                        ) {
                            if (ActivityCompat.shouldShowRequestPermissionRationale(
                                    this@MainActivity,
                                    Manifest.permission.BLUETOOTH_CONNECT
                                )
                            ) {
                                ActivityCompat.requestPermissions(
                                    this@MainActivity,
                                    arrayOf(Manifest.permission.BLUETOOTH_CONNECT), 1
                                )
                            }
                        } else {
                            startActivityForResult(
                                Intent(BluetoothAdapter.ACTION_REQUEST_ENABLE),
                                2
                            )
                            result.success(CURRENT_STATE)
                        }
                    } else {
                        result.success(CURRENT_STATE)
                    }
                }
                METHOD_BLUETOOTH_OFF -> {
                    bluetoothAdapter.disable()
                    CURRENT_STATE = METHOD_BLUETOOTH_OFF
                    result.success(CURRENT_STATE)
                }
                METHOD_STARTING_STATE -> {
                    val filter = IntentFilter(BluetoothAdapter.ACTION_STATE_CHANGED)
                    broadCast = object : MyBroadcastReceiver() {
                        override fun onNewState(boolean: Boolean) {
                           // result.success(if (boolean) METHOD_BLUETOOTH_ON else METHOD_BLUETOOTH_OFF)
                        }
                    }
                    registerReceiver(broadCast, filter)
                    CURRENT_STATE =
                        if (bluetoothAdapter.isEnabled) METHOD_BLUETOOTH_ON else METHOD_BLUETOOTH_OFF
                    result.success(CURRENT_STATE)
                }
            }
        }
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        if (requestCode == 2) {
            if (resultCode == RESULT_OK) {
                CURRENT_STATE = METHOD_BLUETOOTH_ON
            } else if (resultCode == RESULT_CANCELED) {
                CURRENT_STATE = METHOD_BLUETOOTH_OFF
            }
        }
    }

    override fun onRequestPermissionsResult(
        requestCode: Int,
        permissions: Array<out String>,
        grantResults: IntArray
    ) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults)
        when (requestCode) {
            1 -> {
                if (grantResults.isNotEmpty() && grantResults[0] ==
                    PackageManager.PERMISSION_GRANTED
                ) {
                    if ((ActivityCompat.checkSelfPermission(
                            this@MainActivity,
                            Manifest.permission.BLUETOOTH_CONNECT
                        ) ==
                                PackageManager.PERMISSION_GRANTED)
                    ) {
                        startActivityForResult(
                            Intent(BluetoothAdapter.ACTION_REQUEST_ENABLE),
                            2
                        )
                    }
                }
                return
            }
        }
    }

    abstract class MyBroadcastReceiver : BroadcastReceiver() {

        override fun onReceive(context: Context, intent: Intent) {
            val action = intent.getAction()

            if (action.equals(BluetoothAdapter.ACTION_STATE_CHANGED)) {
                val state = intent.getIntExtra(
                    BluetoothAdapter.EXTRA_STATE,
                    BluetoothAdapter.ERROR
                )
                when (state) {
                    BluetoothAdapter.STATE_OFF -> {
                        onNewState(false)
                    }
                    BluetoothAdapter.STATE_TURNING_ON -> {

                    }
                    BluetoothAdapter.STATE_ON -> {
                        onNewState(true)
                    }
                    BluetoothAdapter.STATE_TURNING_OFF -> {

                    }
                }
            }
        }

        protected abstract fun onNewState(boolean: Boolean)
    }
}
