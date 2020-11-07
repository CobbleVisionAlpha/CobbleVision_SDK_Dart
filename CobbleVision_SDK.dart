class CobbleVision_API{

  // ################################################
  // # Incomplete list of imports and environment setup
  // ################################################


  // Variable types are used differently within the framework
  String apiUserName=""
  String apiToken=""
  bool environmentType=false

  String serverAdress="https://www.cobblevision.com"
  bool debugging=false

  list<String> valid_price_categories=["high", "medium", "low"]
  list<String> valid_job_types=["QueuedJob"]

  if(environmentType == false || environmentType === "demo"){
    String BaseURL = "https://www.cobblevision.com/api"
  }else{
    String BaseURL= serverAdress + "/api/"
  }
  
  // ################################################
  // # Handy functions for setting auth and debug
  // ################################################

  // # Function allows you to set the Username and Token for CobbleVision
  // # @function setApiAuth()
  // # @param {String} apiusername
  // # @param {String} apitoken
  // # @returns {bool} Indicating success of setting Api Auth.
  bool setApiAuth(String apiusername, String apitoken){
    this.apiUserName = apiusername
    this.apiToken = apitoken
    return true;
  }

  // # Function allows you to set the debugging variable
  // # @function setDebugging()
  // # @param {Boolean} debugBool
  // # @returns {Boolean} Indicating success of setting Api Auth.
  bool setDebugging(bool debugBool){
    this.debugging=debugBool;
    return true;
  }

  // ################################################
  // # Functions for using the CobbleVision API
  // ################################################

  // # Return of the following functions is specified within this type description
  // # @typedef {Object} Response
  // # @method {String} body returns body of response
  // # @property {Map<String><String>} headers Returns Headers of Response
  // # @property {int} statusCode Returns Text of Response

  // # This function uploads a media file to CobbleVision. You can find it after login in your media storage. Returns a response object with body, response and headers properties, deducted from npm request module
  // # @async
  // # @function uploadMediaFile()  
  // # @param {String} price_category - Either high, medium, low
  // # @param {bool} publicBool - Make Media available publicly or not?
  // # @param {String} name - Name of Media (Non Unique)
  // # @param {list} tags - Tag Names for Media - Array of Strings
  // # @param {String} file - numpy UInt8Array
  // # @returns {Response} This return the UploadMediaResponse. The body is in JSON format.

  Future <Response> uploadMediaFile(String price_category, bool publicBool, String name, list tags, String file) async{
    Future(() => {
      try{
        String endpoint = "media"

        if(this.BaseURL(this.BaseURL.length-1] != "/"){
          throw Exception("BaseURL must end with slash!")
        }

        list<String> keyArray=["price_category", "publicBool", "name", "tags", "Your API Key", "Your API Token"]
        list<String> valueArray=[price_category, publicBool, name, tags, this.apiUserName, this.apiToken]
        list<String> typeArray=["String", "Boolean", "String", "Array", "String", "String"]
  
        try{
          checkTypeOfParameter(valueArray, typeArray)
        }catch(e){
          int err_message=int.parse(e.toString())
          if(err_message is Integer){
            throw Exception("The provided data is not valid:" + keyArray[err_message] + "is not of type" + typeArray[err_message])
          }else{
            throw Exception(e.toString())
          }
        }

        if(valid_price_categories.indexOf(price_category) != -1 ){
          throw Exception("You provided an invalid price_category")
        }

        IOClient client = new http.Client()
        Response response = await http.post(this.BaseURL + endpoint, body: json.encode({"price_category":price_category, "publicBool":publicBool, "name": name, "tags":tags, "file":file}), headers:{"Content-Type":"application/json", "Accept": "application/json", "Basic": + base64encode(utf8.encode({this.apiUserName:this.apiToken}))
        
        return response
       }catch(e){
         throw Exception(e.toString());
       }
     })}
  }

  // # This function deletes Media from CobbleVision
  // # @async
  // # @function deleteMediaFile()  
  // # @param {array} IDArray Array of ID's as Strings
  // # @returns {Response} This return the DeleteMediaResponse. The body is in JSON format.
  Future<Response> deleteMediaFile(list IDArray) async{
    Future(() => {
      try{
        String endpoint = "media"

        if(this.BaseURL(this.BaseURL.length-1] != "/"){
          throw Exception("BaseURL must end with slash!")
        }

        list<String> keyArray=["IDArray", "Your API Key", "Your API Token"]
        list<String> valueArray=[IDArray, this.apiUserName, this.apiToken]
        list<String> typeArray=["Array", "String", "String"]
  
        try{
          checkTypeOfParameter(valueArray, typeArray)
        }catch(e){
          int err_message=int.parse(e.toString())
          if(err_message is Integer){
            throw Exception("The provided data is not valid:" + keyArray[err_message] + "is not of type" + typeArray[err_message])
          }else{
            throw Exception(e.toString())
          }
        }

        invalidMediaIDs = checkIDArrayForObjectID(media)
        if(invalidMediaIDs.length > 0){
          throw Exception("You provided an invalid media ID.")
        }

        IOClient client = new http.Client()
        Response response = await http.delete(this.BaseURL + endpoint + "?id=" + json_encode(IDArray), headers:{"Content-Type":"application/json", "Accept": "application/json", "Basic": + base64encode(utf8.encode({this.apiUserName:this.apiToken}))
        
        return response
       }catch(e){
         throw Exception(e.toString());
       }
     })}
  }


  // # Launch a calculation with CobbleVision's Web API. Returns a response object with body, response and headers properties, deducted from npm request module;
  // # @async
  // # @function launchCalculation() 
  // # @param {array} algorithms Array of Algorithm Names
  // # @param {array} media Array of Media ID's  
  // # @param {string} type Type of Job - Currently Always "QueuedJob"
  // # @param {string} [notificationURL] Optional - Notify user upon finishing calculation!
  // # @returns {Response} This returns the LaunchCalculationResponse. The body is in JSON format.
  Future<Response> launchCalculation(list algorithms, list media, String type, String notificationURL) async{
    Future(() => {
      try{
        String endpoint = "calculation"

        if(this.BaseURL(this.BaseURL.length-1] != "/"){
          throw Exception("BaseURL must end with slash!")
        }

        list<String> keyArray=["algorithms", "media", "type", "notificationURL", "Your API Username", "Your API Token"]
        list<String> valueArray=[algorithms, media, type, notificationURL, apiUserName, apiToken]
        list<String> typeArray=["Array", "Array", "String", "String", "String", "String"]
  
        try{
          checkTypeOfParameter(valueArray, typeArray)
        }catch(e){
          int err_message=int.parse(e.toString())
          if(err_message is Integer){
            throw Exception("The provided data is not valid:" + keyArray[err_message] + "is not of type" + typeArray[err_message])
          }else{
            throw Exception(e.toString())
          }
        }

        invalidMediaIDs = checkIDArrayForObjectID(media)
        if(invalidMediaIDs.length > 0){
          throw Exception("You provided an invalid media ID.")
        }

        invalidAlgIDs = checkIDArrayForObjectID(algorithms)
        if(invalidAlgIDs.length > 0){
          throw Exception("You provided an invalid algorithm ID.")
        }

        var jsonObject = json.decode({"algorithms": algorithms, "media":media, "type":type})
        
        if(notificationURL != null){
          jsonObject["notificationURL"] = notificationURL
        }

        IOClient client = new http.Client()
        Response response = await http.post(this.BaseURL + endpoint, body: jsonObject , headers:{"Content-Type":"application/json", "Accept": "application/json", "Basic": + base64encode(utf8.encode({this.apiUserName:this.apiToken}))
        
        return response
       }catch(e){
         throw Exception(e.toString());
       }
     })}
  }


  // # This function waits until the given calculation ID's are ready to be downloaded!
  // # @async
  // # @function waitForCalculationCompletion() 
  // # @param {array} calculationIDArray Array of Calculation ID's
  // # @returns {Response} This returns the WaitForCalculationResponse. The body is in JSON format.   
  Future<Response> waitForCalculationCompletion(list calculationIDArray) async{
    Future(() => {
      try{
        String endpoint = "calculation"

        if(this.BaseURL(this.BaseURL.length-1] != "/"){
          throw Exception("BaseURL must end with slash!")
        }

        list<String> keyArray=["calculationIDArray", "Your API Username", "Your API Token"]
        list<String> valueArray=[calculationIDArray, apiUserName, apiToken]
        list<String> typeArray=["Array", "String", "String"]
  
        try{
          checkTypeOfParameter(valueArray, typeArray)
        }catch(e){
          int err_message=int.parse(e.toString())
          if(err_message is Integer){
            throw Exception("The provided data is not valid:" + keyArray[err_message] + "is not of type" + typeArray[err_message])
          }else{
            throw Exception(e.toString())
          }
        }

        invalidCalcIDs = checkIDArrayForObjectID(calculationIDArray)
        if(invalidCalcIDs.length > 0){
          throw Exception("You provided an invalid calc ID.")
        }
        bool calculationFinishedBool = false
        while(!calculationFinishedBool){
        
          IOClient client = new http.Client()
          Response response = await http.get(this.BaseURL + endpoint + "?id=" + json_encode(calculationIDArray), headers:{"Content-Type":"application/json", "Accept": "application/json", "Basic": + base64encode(utf8.encode({this.apiUserName:this.apiToken}))
          var responseJSON = json_decode(response.body) as List
          if(responseJSON is of List){
            for(int v=0, v<responseJSON.length, v++){
              if(responseJSON[v].containsKey("status")){
                if(responseJSON[v].status === "finished"){
                  calculationFinishedBool=true
                }else{
                  calculationFinishedBool=false
                  break;
                }
              }
            }
          }else{
            if(responseJSON.containsKey("error")){
              calculationFinishedBool=true
            }
          }
        }
        return response
       }catch(e){
         throw Exception(e.toString());
       }
     })}
  }

  // # This function deletes Result Files or calculations in status "waiting" from CobbleVision. You cannot delete finished jobs beyond their result files, as we keep them for billing purposes.
  // # @async
  // # @function deleteCalculation()
  // # @param {array} IDArray Array of ID's as Strings
  // # @returns {Response} This returns the DeleteCalculationResponse. The body is in JSON format.
  
  Future<Response> deleteCalculation(list IDArray) async{
    Future(() => {
      try{
        String endpoint = "media"

        if(this.BaseURL(this.BaseURL.length-1] != "/"){
          throw Exception("BaseURL must end with slash!")
        }

        list<String> keyArray=["IDArray", "Your API Key", "Your API Token"]
        list<String> valueArray=[IDArray, this.apiUserName, this.apiToken]
        list<String> typeArray=["Array", "String", "String"]
  
        try{
          checkTypeOfParameter(valueArray, typeArray)
        }catch(e){
          int err_message=int.parse(e.toString())
          if(err_message is Integer){
            throw Exception("The provided data is not valid:" + keyArray[err_message] + "is not of type" + typeArray[err_message])
          }else{
            throw Exception(e.toString())
          }
        }

        invalidMediaIDs = checkIDArrayForObjectID(media)
        if(invalidMediaIDs.length > 0){
          throw Exception("You provided an invalid media ID.")
        }

        IOClient client = new http.Client()
        Response response = await http.delete(this.BaseURL + endpoint + "?id=" + json_encode(IDArray), headers:{"Content-Type":"application/json", "Accept": "application/json", "Basic": + base64encode(utf8.encode({this.apiUserName:this.apiToken}))
        
        return response
       }catch(e){
         throw Exception(e.toString());
       }
     })}
  }

  // # Get Calculation Result with CobbleVision's Web API. Returns a response object with body, response and headers properties, deducted from npm request module;
  // # @async
  // # @function getCalculationResult()
  // # @param {array} IDArray ID of calculation to return result Array 
  // # @param {boolean} returnOnlyStatusBool Return full result or only status? See Doc for more detailed description!
  // # @returns {Response} This returns the GetCalculationResult. The body is in json format.

  // # Request your calculation result by ID with the CobbleVision API. Returns a response object with body, response and headers properties, deducted from npm request module;
  // # @async
  // # @function getCalculationVisualization()
  // # @param {string} id ID of calculation to return result/check String
  // # @param {boolean} returnBase64Bool Return Base64 String or image buffer as string?
  // # @param {integer} width target width of visualization file
  // # @param {integer} height target height of visualization file
  // # @returns {Response} This returns the GetCalculationVisualization Result. The body is in binary format. 
  
  // ###################################################
  // ## Helper Functions
  // ###################################################

  // # TypeChecking of Values
  // # @sync
  // # @function checktypeOfParameter()
  // # @param {array} targetArray Array of values to be checked
  // # @param {array} typeArray Array of types in strings to be checked against
  // # @returns {boolean} Success of Check

  // # Check Array of Mongo IDs for Invalid Values
  // # @sync
  // # @function checkIDArrayForInvalidValues()
  // # @param {array} IDArray Array of Mongo IDs
  // # @returns {boolean} Success of Check

  // # Verify url using python regex combination
  // # @sync
  // # @function validate_url()
  // # @param {tURL} URL target URL to verify
  // # @returns {boolean} Success of Check
 
  // # Wait using python sleep function
  // # @async
  // # @function wait()
  // # @param {number} timeInMS time to wait in ms
  // # @returns {boolean} Success of Wait
