



import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flaskmob/DataModel/poll.dart';
import 'package:http/http.dart' as http;
class PollService{



  Future<List<Poll>?> getAllPolls() async
  {

    try{
      List<Poll>? data;

      final response = await http.get(
        Uri.parse('https://flash-mode-final.vercel.app/api/posts'),
      );
      final body = jsonDecode(response.body);
      if (response.statusCode == 200) {
        data = [];
        data = body["data"].map<Poll>((json) => Poll.fromJson(json)).toList();

        print("Poll Length : "+data!.length.toString());

        data.shuffle();

        return data;

      } else {

        return [];
      }
    }
    on DioError  catch (ex) {
      if(ex.type == DioErrorType.other ||ex.type == DioErrorType.connectTimeout || ex.type == DioErrorType.receiveTimeout ){
        print("Error from getAllPolls" + ex.toString());
        return null;
      }
      else{
        print("Error from getAllPolls" + ex.toString());
        return null;
      }
    }
    on SocketException catch (errs) {
      print("Error from getAllPolls" + errs.toString());
      return null;
    } on TimeoutException catch (ew) {
      print("Error from getAllPolls" + ew.toString());
      return null;
    }
    catch(err)
    {
      print("Error from getAllPolls" + err.toString());
      return null;
    }

  }



  Future<Poll?> postResult(String optionId,String questionId) async
  {

    try{
      List<Poll>? data;
      // print(optionId);
      // print(questionId);
      final Dio _dio = Dio();

      Response response = await _dio.put(
          'https://flash-mode-final.vercel.app/api/posts/'+questionId,
        data: jsonEncode({
              "id":optionId
            }),
      );
      final body = response.data;

      if (response.statusCode == 200) {

        if(body["error"])
          {
            return null;
          }
        else {
          return Poll.fromJson(body["data"]);
        }

      } else {

        return null;
      }
    }
    on DioError  catch (ex) {
      if(ex.type == DioErrorType.other ||ex.type == DioErrorType.connectTimeout || ex.type == DioErrorType.receiveTimeout ){
        print("Error from postResult" + ex.toString());
        return null;
      }
      else{
        print("Error from postResult" + ex.toString());
        return null;
      }
    }
    on SocketException catch (errs) {
      print("Error from postResult" + errs.toString());
      return null;
    } on TimeoutException catch (ew) {
      print("Error from postResult" + ew.toString());
      return null;
    }
    catch(err)
    {
      print("Error from getAllPolls" + err.toString());
      return null;
    }

  }


}