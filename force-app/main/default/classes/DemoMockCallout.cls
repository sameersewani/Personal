@isTest
global class DemoMockCallout implements HttpCalloutMock 
{
    global HTTPResponse respond(HTTPRequest request)
    {
        string fullJson = '';
        if (request.getEndpoint().endsWith('https://api.stripe.com/v1/customers') ) 
        {
            fullJson ='{"id": "cus_NKDyX9uGehg3PQ","object": "customer","address": null,"balance": 0,"created": 1675946795,"currency": null,"default_currency": null,"default_source": null,"delinquent": false,"description": null,"discount": null,"email": null,"invoice_prefix": "4240CAEA", "invoice_settings": {"custom_fields": null,"default_payment_method": null,"footer": null,"rendering_options": null},"livemode": false,"metadata": {},"name": "sam","next_invoice_sequence": 1,"phone": null,"preferred_locales": [],"shipping": null,"tax_exempt": "none","test_clock": null}';
        }
        
        else if (request.getEndpoint().endsWith('https://api.stripe.com/v1/charges') ) 
        {
            fullJson ='{"id": "ch_3MZaByAgRJNLwrDT1NF9mqJe","object": "charge","amount": 2000,"amount_captured": 2000,"amount_refunded": 0,"application": null,"application_fee": null,"application_fee_amount": null,"balance_transaction": "txn_3MZaByAgRJNLwrDT1DIkwznR","billing_details": {"address": {"city": null,"country": null,"line1": null,"line2": null,"postal_code": null,"state": null},"email": null,"name": null,"phone": null},"calculated_statement_descriptor": "Stripe","captured": true,"created": 1675949378,"currency": "aud","customer": null,"description": null, "destination": null,dispute": null,"disputed": false,"failure_balance_transaction": null,"failure_code": null,"failure_message": null, "fraud_details": {},"invoice": null,"livemode": false,"metadata": {},"on_behalf_of": null,"order": null,"outcome": { "network_status": "approved_by_network","reason": null,"risk_level": "normal","risk_score": 8,"seller_message": "Payment complete.","type": "authorized"},"paid": true,"payment_intent": null,"payment_method": "card_1MZaByAgRJNLwrDTOzBow0oD","payment_method_details": {"card": {"brand": "mastercard","checks": {"address_line1_check": null,"address_postal_code_check": null,"cvc_check": null},"country": "US","exp_month": 2,"exp_year": 2024,"fingerprint": "6Gr9X1hxTPUt247x","funding": "credit","installments": null,"last4": "4444","mandate": null,"network": "mastercard","three_d_secure": null,"wallet": null},"type": "card"},"receipt_email": null,"receipt_number": null,"receipt_url": "https://pay.stripe.com/receipts/payment/CAcaFwoVYWNjdF8xTDhJSlRBZ1JKTkx3ckRUKMPqk58GMgbc3797H986LBaOL5ft6Pb74-yEyOlBJSaHlDLEipgS-GrmLim199w8WRn4NBaIHki89dHi","refunded": false,"refunds": {"object": "list","data": [],"has_more": false,"total_count": 0,"url": "/v1/charges/ch_3MZaByAgRJNLwrDT1NF9mqJe/refunds"},"review": null,"shipping": null,"source": {"id": "card_1MZaByAgRJNLwrDTOzBow0oD","object": "card", "address_city": null,"address_country": null,"address_line1": null,"address_line1_check": null,"address_line2": null,"address_state": null,"address_zip": null,"address_zip_check": null,"brand": "MasterCard","country": "US","customer": null,"cvc_check": null,"dynamic_last4": null,"exp_month": 2,"exp_year": 2024,"fingerprint": "6Gr9X1hxTPUt247x","funding": "credit","last4": "4444","metadata": {},"name": null,"tokenization_method": null},"source_transfer": null, "statement_descriptor": null,"statement_descriptor_suffix": null,"status": "succeeded","transfer_data": null,"transfer_group": null}';
        }
        
        HttpResponse response = new HttpResponse();
        response.setHeader('Authorization','bearer sk_test_51L8IJTAgRJNLwrDT06ZO9xWB2CO7uEnQ6Vnjmb2BJA9pxGFIorbIm9PiqE7kQ4wTUqP2AhNqSz3ImlRShL67P8Lv00EO5OkBoX');
        response.setBody(fullJson);
        response.setStatusCode(200);
        return response;
    }
}