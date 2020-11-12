import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_share/social_share.dart';
import 'package:noteandsharedwithsql/models/item.model.dart';
import 'package:noteandsharedwithsql/controllers/item.controller.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import '../app_status.dart';

class MainApp extends StatefulWidget {
  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final _navigatorKey = GlobalKey<NavigatorState>();
  var _controller = ItemController();

  List _listagem=[];
  ItemController _icontroller = null;

  String _theme = 'Light';
  var _themeData = ThemeData.light();

  @override
  void initState() {
    super.initState();
    _loadTheme();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.getAll().then((data) {
        setState(() {
          _listagem = _controller.list;
        });
      });
    });
  }
  //Forms
  final _formKey = GlobalKey<FormState>();
  var _nameitemController = TextEditingController();
  var _whoController = TextEditingController();
  var _priceController = TextEditingController();
  var _amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var scaffold = Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(255,153,153,10),
          title: Text('To List'),
          titleSpacing: 15,
          actions: [
            _PopupMenuButton(),
            IconButton(
              icon: Icon(Icons.share),
              onPressed: () async{
                var itens = _listagem.reduce((value, element) => value + '\n' + element);
                SocialShare.shareWhatsapp("For Share:\n" + itens).then((data)
                {
                  print(data);
                });
              },
            )
          ],
        ),
        //Data about the List

         body: Scrollbar(
          child: Observer(builder:(BuildContext _context){
            _icontroller = Provider.of<ItemController>(_context);
            if(_icontroller.status == AppStatus.success){
              return ListView(
              padding: const EdgeInsets.symmetric(vertical: 10),
              children: [
                for (int i = 0; i < _listagem.length; i++)
                  ListTile(
                      leading: ExcludeSemantics(
                          child: CircleAvatar(child:Text('${i + 1}'),
                            backgroundColor: Color.fromRGBO(255,153,153,10),
                            foregroundColor: Colors.white,
                            maxRadius: 17,
                          )
                      ),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children:[
                          //Name of the bottons in the row
                          _listItemName(i),
                          _listwhoController(i),
                          _listItemPrice(i),
                          _listItemAmount(i),
                          _listDelete(i),
                        ],
                      )
                  ),
              ],
            );
            }else{
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          })
        ), 

        //About the floating button ADD in the bottom of the page
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add_shopping_cart,color: Colors.white, size: 25),
          backgroundColor: Color.fromRGBO(255,153,153,10),
          onPressed: () => _displayDialog(), //_displayDialog is the fuction for create the new thing in the list
        ),
      );
    return MultiProvider(
      providers:[
        Provider<ItemController>.value(value: ItemController()),
      ],
      child: MaterialApp(
      navigatorKey: _navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: _themeData,
      home: scaffold,
    ),
    );
  }
// Carregando o tema salvo pelo usuário
  _loadTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _theme = (prefs.getString('theme') ?? 'Light');
      _themeData = _theme == 'Dark' ? ThemeData.dark() : ThemeData.light();
    });
  }
// Carregando o tema salvo pelo usuário
  _setTheme(theme) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _theme = theme;
      _themeData = theme == 'Dark' ? ThemeData.dark() : ThemeData.light();
      prefs.setString('theme', theme);
    });
  }

  //Menu Change Theme
  _PopupMenuButton(){
    return PopupMenuButton(
      onSelected: (value) => _setTheme(value) ,
      itemBuilder: (context) {
        var list = List<PopupMenuEntry<Object>>();
        list.add(
          PopupMenuItem(
              child: Text("Theme Configuration")
          ),
        );
        list.add(
          PopupMenuDivider(
            height: 10,
          ),
        );
        list.add(
          CheckedPopupMenuItem(
            child: Text("Light"),
            value: 'Light',
            checked: _theme == 'Light',
          ),
        );
        list.add(
          CheckedPopupMenuItem(
            child: Text("Dark"),
            value: 'Dark',
            checked: _theme == 'Dark',
          ),
        );
        return list;
      },
    );
  }

  //Label Name
  _listItemName(int i)
  {
    return Expanded(
      child: Text(
          _listagem[i].nomeproduto.toString(),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            fontStyle: FontStyle.italic,
          )
      ),
    );
  }
  //Label who is the person?
  _listwhoController(int i)
  {
    return Expanded(
      child: Text(
          _listagem[i].pessoa.toString(),
          style: TextStyle(
            fontSize: 17,
          )
      ),
    );
  }

  //Label Price
  _listItemPrice(int i)
  {
    String text = _listagem[i].preco != null ? "R\$ "+_listagem[i].preco.toStringAsFixed(2) : "";
    return Container(
      child: Text(
          text
      ),
    );
  }

  //Quantidade
  _listItemAmount(int i){
    String text = _listagem[i].quantidade != null ? "x"+_listagem[i].quantidade.toString() : "";
    return Expanded(
      child: Text(
          text
      ),
    );
  }
  //Botton Remove: Remove something in the list
  _listDelete(int i)
  {
    return IconButton(
      icon: Icon(
        Icons.delete_outline,
        size: 22.0,
        color: Colors.cyan,
      ),
      onPressed: (){
          _controller.delete(_listagem[i].id).then((data) {
            setState(() {
              _listagem = _controller.list;
            });
          });
      },
    );
  }

  //About the new item at the list
  _displayDialog() async {
    final context = _navigatorKey.currentState.overlay.context;
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Form(
                key: _formKey,
                child: SingleChildScrollView(
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _nameitemController,
                          validator: (s) {
                            if (s.length < 2)
                              return "Please, type the item with less 2 character's";
                            else
                              return null;
                          },
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(labelText: "Name of the Item*"),
                        ),
                        TextFormField(
                          controller: _whoController,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(labelText: "Who is the person"),
                        ),
                        TextFormField(
                          controller: _priceController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(labelText: "Price", prefixText: "R\$ "),
                        ),
                        TextFormField(
                          controller: _amountController,
                          validator: (s) {
                            if (s.isEmpty){
                              return null;
                            }else{
                              int value = int.tryParse(s) ?? 1;
                              if(value < 1){
                                return "Please enter a valid value";
                              }
                                return null;
                            }
                          },
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              labelText: "How much?",
                              prefixText: "x "
                          ),
                        ),
                      ],
                    )
                )
            ),
            actions: <Widget>[
              FlatButton(
                child: new Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: new Text('Save'),
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    _controller.create(Produto(
                          nomeproduto: _nameitemController.text,
                          pessoa: _whoController.text,
                          preco: double.tryParse(_priceController.text) ?? 0,
                          quantidade: int.tryParse(_amountController.text) ?? 1
                      ));
                    setState(() {
                      _listagem = _controller.list;
                      _nameitemController.text = "";
                      _whoController.text = "";
                      _priceController.text = "";
                      _amountController.text = "";
                    });
                    Navigator.of(context).pop();
                  }
                },
              )
            ],
          );
        });
  }

}
