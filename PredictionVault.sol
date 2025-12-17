// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

// Importamos la interfaz IERC20 para interactuar con el token GOALCoin
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
// Importamos Ownable para tener una función de retiro segura (solo el dueño puede hacerlo)
import "@openzeppelin/contracts/access/Ownable.sol";

contract PredictionVault is Ownable {

    IERC20 public immutable token;

    mapping(address => bytes) public userPredictions;

    constructor(address _tokenAddress) Ownable(msg.sender) {
        token = IERC20(_tokenAddress);
    }

    function deposit(uint256 _amount, bytes memory _predictionData) public {
        
        require(_amount > 0, "Vault: Deposit amount must be greater than zero.");

        // msg.sender = user who deposit to
        // address(this) = Vault who receive
        bool success = token.transferFrom(msg.sender, address(this), _amount);
        
        require(success, "Vault: TransferFrom failed. Check allowance from GOALCoin.");
        
        userPredictions[msg.sender] = _predictionData;

        emit DepositMade(msg.sender, _amount);
    }

    function withdraw(address _recipient, uint256 _amount) public onlyOwner {
        //move from vault to receiver
        token.transfer(_recipient, _amount);
    }
    
    event DepositMade(address indexed user, uint256 amount);

}