pragma solidity ^0.4.13;

contract Agro {
	using SafeMath for uint256;
    
	struct Animal {
        uint256 dataRegistro;
		string produtor;
		string caracteristicaAnimal;
		string codRegistroMA;
		bool registrado;
		bool consumido;

		uint256 dataBeneficiamento;
		string codRegistroBeneficiamento;
    }

	struct Produto {
		uint256 dataCompra;
		string idAnimal;
		bool validado;
		uint256 rate; //0 a 10
	}

	address public owner;
	

	bool private registrado;
	bool private consumido;

	event EventRegistered(address indexed _who, string _id, uint256 _date);
	event EventConsumed(address indexed _who, string _id, uint256 _date);

	mapping(string => Animal) registros;
	mapping(string => Produto) consumos;

	modifier onlyOwner() {
		require(msg.sender == owner);
		_;
	}

	function Agro() {
		owner = msg.sender;
	}
		
	function Registro(string p_id, uint256 p_dataRegistro, string p_produtor, string p_caracteristicaAnimal, string p_codRegistroMA) onlyOwner {	
		var emptystring = sha3("");
		require(!registros[p_id].registrado);
		require(!(sha3(p_produtor) == emptystring));
		require(!(sha3(p_caracteristicaAnimal) == emptystring));
		require(!(sha3(p_codRegistroMA) == emptystring));
		require(!(sha3(p_id) == emptystring));
		require(!(p_dataRegistro == 0));
		//check the strings and numbers

		registros[p_id].dataRegistro = p_dataRegistro;
		registros[p_id].produtor = p_produtor;
		registros[p_id].caracteristicaAnimal = p_caracteristicaAnimal;
		registros[p_id].codRegistroMA = p_codRegistroMA;
		registros[p_id].registrado =  true;
		registros[p_id].consumido =  false;
		registros[p_id].dataBeneficiamento =  0;
		registros[p_id].codRegistroBeneficiamento =  "";

		EventRegistered(msg.sender, p_id, p_dataRegistro);

	}

	function ConsultaRegistro(string p_id) constant returns (uint256, string, string, string, bool, bool) {
		return (registros[p_id].dataRegistro,
				registros[p_id].produtor,
				registros[p_id].caracteristicaAnimal,
				registros[p_id].codRegistroMA,
				registros[p_id].registrado,
				registros[p_id].consumido);
	}

	function Consumo(string p_id, uint256 p_dataBeneficimento, string p_codRegistro) {
		var emptystring = sha3("");
		require(!registros[p_id].registrado);
		require(!(sha3(p_produtor) == emptystring));
		require(!(sha3(p_caracteristicaAnimal) == emptystring));
		require(!(sha3(p_codRegistroMA) == emptystring));
		require(!(sha3(p_id) == emptystring));
		require(!(p_dataRegistro == 0));

		registros[p_id].consumido = true;
		registros[p_id].dataBeneficiamento = p_dataBeneficimento;
		registros[p_id].codRegistroBeneficiamento = p_codRegistro;
		
		consumos[p_codRegistro].dataCompra = p_dataBeneficimento;
		consumos[p_codRegistro].idAnimal = p_id;
		consumos[p_codRegistro].validado = false;

		EventConsumed(msg.sender, p_codRegistro, p_dataBeneficimento);
	}

	function ConsultaConsumo(string p_codRegistro) constant returns (uint256, string, uint256, bool, bool) {
	
		return (
			consumos[p_codRegistro].dataCompra,
			consumos[p_codRegistro].idAnimal,
			consumos[p_codRegistro].rate,
			consumos[p_codRegistro].validado,
			registros[consumos[p_codRegistro].idAnimal].consumido
		);
	}

	function Validacao(uint256 p_rate, uint256 p_dataCompra, string p_codRegistro, string p_id) {
		
	}

	function ConsultaValidacao(string p_codRegistro) constant returns (uint256, uint256, bool) {
	}

	function Consulta(string p_codRegistro, string p_id) constant returns (string, uint256, string, uint256, uint256, uint256) {
	}
}

library SafeMath {
	function times(uint256 x, uint256 y) internal returns (uint256) {
		uint256 z = x * y;
		assert(x == 0 || (z / x == y));
		return z;
	}
	
	function plus(uint256 x, uint256 y) internal returns (uint256) {
		uint256 z = x + y;
		assert(z >= x && z >= y);
		return z;
	}

  	function div(uint256 a, uint256 b) internal constant returns (uint256) {
	    // assert(b > 0); // Solidity automatically throws when dividing by 0
	    uint256 c = a / b;
	    // assert(a == b * c + a % b); // There is no case in which this doesn't hold
	    return c;
  	}
}