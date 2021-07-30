
abstract class GlobalVars {

  static String? token;

  static const String finishPage = '''
  <style>
    .container {
        display: flex;
        justify-content: center;
        align-items: center;
        flex-direction: column;
    }
    .text {
        text-align: center;
        font-family: sans-serif;
    }
</style>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  <style type="text/css">
   TABLE {
    width: 100%; /* Ширина таблицы */
    height: 100%; /* Высота таблицы */   
   } 
  </style>
 </head>
 <body bgcolor="#f5f8e7">
  <table>
   <tr>
    <td align="center">
        <div class="container">
            <Img src="https://maxtreat.ru/wp-content/uploads/2020/07/galochka.png" Width="130" Height="100">
            <br>
                <h2 class="text">Success!</h2>
        </div>
    </td>
   </tr>
  </table> 
 </body>
</html>
  ''';

}