<?php

require 'vendor/autoload.php';
use AfricasTalking\SDK\AfricasTalking;

class SmsService {
    protected $phone;
    protected $AT;
    private $apiKey = "atsk_c022d905ce0a7de137308100cb28c9ab2b38179e82d7ed034233c8bfb2e21411bdab6eb2";
    private $username = "sandbox";

    public function __construct($phone) {
        error_log("Initializing SMS Service for phone: " . $phone);
        $this->phone = $phone;
        try {
            $this->AT = new AfricasTalking($this->username, $this->apiKey);
            error_log("Africa's Talking SDK initialized successfully");
        } catch (Exception $e) {
            error_log("Error initializing Africa's Talking SDK: " . $e->getMessage());
            throw $e;
        }
    }

    public function sendSms($message, $recipients) {
        try {
            error_log("Attempting to send SMS to: " . $recipients);
            error_log("Message content: " . $message);
            
            if (!$this->AT) {
                error_log("Africa's Talking SDK not initialized");
                return false;
            }

            $sms = $this->AT->sms();
            if (!$sms) {
                error_log("Failed to get SMS service from Africa's Talking SDK");
                return false;
            }

            $params = [
                'username' => $this->username,
                'to' => $recipients,
                'message' => $message,
                'from' => "URUMURI"
            ];

            error_log("Sending SMS with params: " . json_encode($params));
            
            $result = $sms->send($params);
            error_log("SMS API Response: " . json_encode($result));

            if (isset($result['status']) && $result['status'] === 'success') {
                error_log("SMS sent successfully");
                return $result;
            }
            
            error_log("SMS sending failed: " . json_encode($result));
            return false;
        } catch (Exception $e) {
            error_log("SMS Error: " . $e->getMessage());
            error_log("Stack trace: " . $e->getTraceAsString());
            return false;
        }
    }
}

function sendSMS($phoneNumber, $message) {
    try {
        error_log("sendSMS function called with phone: " . $phoneNumber);
        $smsService = new SmsService($phoneNumber);
        $result = $smsService->sendSms($message, $phoneNumber);
        
        if ($result && isset($result['status']) && $result['status'] === 'success') {
            error_log("SMS sent successfully via sendSMS function");
            return 'success';
        }
        
        error_log("SMS sending failed via sendSMS function");
        return 'error';
    } catch (Exception $e) {
        error_log("Error in sendSMS function: " . $e->getMessage());
        error_log("Stack trace: " . $e->getTraceAsString());
        return 'error';
    }
}