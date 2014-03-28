var alfabeto = [
	{"id": 1, "letra": "a"},
	{"id": 2, "letra": "b"},
	{"id": 3, "letra": "c"},
	{"id": 4, "letra": "d"},
	{"id": 5, "letra": "e"},
	{"id": 6, "letra": "f"},
	{"id": 7, "letra": "g"},
	{"id": 8, "letra": "h"},
	{"id": 9, "letra": "i"},
	{"id": 10, "letra": "j"},
	{"id": 11, "letra": "k"},
	{"id": 12, "letra": "l"},
	{"id": 13, "letra": "m"},
	{"id": 14, "letra": "n"},
	{"id": 15, "letra": "o"},
	{"id": 16, "letra": "p"},
	{"id": 17, "letra": "q"},
	{"id": 18, "letra": "r"},
	{"id": 19, "letra": "s"},
	{"id": 20, "letra": "t"},
	{"id": 21, "letra": "u"},
	{"id": 22, "letra": "v"},
	{"id": 23, "letra": "w"},
	{"id": 24, "letra": "x"},
	{"id": 25, "letra": "y"},
	{"id": 26, "letra": "z"}
];

function buscaLetra(id)
{
	for(var i=0; i<alfabeto.length; i++)
	{
		if(alfabeto[i].id == id)
		{
			return alfabeto[i].letra;
		}
	}
	return -1;
}

function buscaCod(letra){
	for(var i=0; i<alfabeto.length; i++)
	{
		if(alfabeto[i].letra == letra)
		{
			return alfabeto[i].id;
		}
	}
	return -1;
}

function CaesarEncryption(pure, key){
	var cipherText="";
	var atual;
	pure = pure.toLowerCase();

	for(var i=0; i<pure.length; i++){
		if(!isNaN(pure.charAt(i))){
			cipherText += pure.charAt(i);
			continue;
		}


		if(buscaCod(pure.charAt(i))+key > 26){
			atual = (buscaCod(pure.charAt(i))+key) - 26;
		}
		else{
			atual = buscaCod(pure.charAt(i))+key;
		}


		cipherText += buscaLetra(atual);
	}

	return cipherText;

}

function CaesarDecryption(cipher, key){
	var pureText = "";
	var atual;
	cipher = cipher.toLowerCase();

	for(var i=0; i<cipher.length; i++){
		if(!isNaN(cipher.charAt(i))){
			pureText += cipher.charAt(i);
			continue;
		}


		if(buscaCod(cipher.charAt(i))-key < 0){
			atual = (buscaCod(cipher.charAt(i))-key) + 26;
		}
		else{
			atual = buscaCod(cipher.charAt(i))-key;
		}


		pureText += buscaLetra(atual);
	}

	return pureText;
}