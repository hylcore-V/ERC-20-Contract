// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

interface IERC20 {
    function totalSupply() external view returns (uint256);

    function balanceOf(address _account) external view returns (uint256);

    function transfer(address _to, uint256 _amount) external returns (bool);

    function allowance(
        address _owner,
        address _spender
    ) external view returns (uint256);

    function approve(address _spender, uint256 _amount) external returns (bool);

    function transferFrom(
        address _from,
        address _receptor,
        uint256 _amount
    ) external returns (bool);

    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    event Approval(
        address indexed _owner,
        address indexed _spender,
        uint256 _value
    );
}

abstract contract ERC20 is IERC20 {
    mapping(address => uint256) private users_balances;
    mapping(address owner => mapping(address spender => uint256 balance))
        private users_allowances;

    uint256 private total_supply;
    string private name;
    string private symbol;

    constructor(string memory _name, string memory _symbol) {
        name = _name;
        symbol = _symbol;
    }

    function token_name() public view virtual returns (string memory) {
        return name;
    }

    function token_symbol() public view virtual returns (string memory) {
        return symbol;
    }

    function token_decimals() public view virtual returns (uint8) {
        return 18;
    }

    function totalSupply() public view override returns (uint256) {
        return total_supply;
    }

    function balanceOf(
        address _account
    ) public view virtual override returns (uint256) {
        return users_balances[_account];
    }

    function transfer(
        address _to,
        uint256 _amount
    ) public virtual override returns (bool) {
        address owner = msg.sender;
        _transfer(owner, _to, _amount);
        return true;
    }

    function allowance(
        address _owner,
        address _spender
    ) public view virtual override returns (uint256) {
        return users_allowances[_owner][_spender];
    }

    function approve(
        address _spender,
        uint256 _amount
    ) public virtual override returns (bool) {
        address owner = msg.sender;
        _approve(owner, _spender, _amount);
        return true;
    }

    function transferFrom(
        address _from,
        address _to,
        uint256 _amount
    ) public virtual override returns (bool) {
        address spender = msg.sender;
        _spendAllowance(_from, spender, _amount);
        _transfer(_from, _to, _amount);
        return true;
    }

    function incrementAllowance(
        address _spender,
        uint256 _addedValue
    ) public virtual returns (bool) {
        address owner = msg.sender;
        _approve(
            owner,
            _spender,
            users_allowances[owner][_spender] + _addedValue
        );
        return true;
    }

    function decreaseAllowance(
        address _spender,
        uint256 _decreaseValue
    ) public virtual returns (bool) {
        address owner = msg.sender;
        uint256 currentAllowance = users_allowances[owner][_spender];
        require(
            currentAllowance >= users_allowances[owner][_spender],
            "ERC20: decreased allowance below zero"
        );
        unchecked {
            _approve(owner, _spender, currentAllowance - _decreaseValue);
        }
        return true;
    }

    function _transfer(
        address _from,
        address _to,
        uint256 _amount
    ) internal virtual {
        require(_from != address(0), "ERC20: owner address is empty");
        require(_to != address(0), "ERC20: receiver address is empty");
        _beforeTransferToken(_from, _to, _amount);
        uint256 fromBalance = users_balances[_from];
        require(fromBalance >= _amount, "ERC20: not sufficient amount");
        unchecked {
            users_balances[_from] = fromBalance - _amount;
        }
        users_balances[_to] += _amount;
        emit Transfer(_from, _to, _amount);
        afterTokenTransaction(_from, _to, _amount);
    }

    function _mint(address _account, uint _amount) internal virtual {
        require(_account != address(0), "ERC20: address is empty");
        _beforeTransferToken(address(0), _account, _amount);
        total_supply += _amount;
        users_balances[_account] += _amount;
        emit Transfer(address(0), _account, _amount);
        afterTokenTransaction(address(0), _account, _amount);
    }

    function _burn(address _account, uint256 _amount) internal virtual {
        require(_account != address(0), "ERC: address is empty");
        _beforeTransferToken(_account, address(0), _amount);
        uint256 accountBalance = users_balances[_account];
        require(
            accountBalance >= _amount,
            "ERC20: burn amount exceeds balance"
        );
        unchecked {
            users_balances[_account] -= _amount;
        }
        total_supply -= _amount;
        emit Transfer(_account, address(0), _amount);
        afterTokenTransaction(_account, address(0), _amount);
    }

    function _approve(
        address _owner,
        address _spender,
        uint256 _amount
    ) internal virtual {
        require(_owner != address(0), "ERC20: approve from zero address");
        require(_spender != address(0), "ERC20: approve to zero address");
        users_allowances[_owner][_spender] = _amount;
        emit Approval(_owner, _spender, _amount);
    }

    function _spendAllowance(
        address _owner,
        address _spender,
        uint256 _amount
    ) internal virtual {
        uint256 currentAllowance = allowance(_owner, _spender);
        if (currentAllowance != type(uint256).max) {
            require(
                currentAllowance >= _amount,
                "ERC20: insufficient balances"
            );
            unchecked {
                _approve(_owner, _spender, _amount);
            }
        }
    }

    function _beforeTransferToken(
        address _from,
        address _to,
        uint256 _amount
    ) internal virtual {}

    function afterTokenTransaction(
        address _from,
        address _to,
        uint256 _amount
    ) internal virtual {}
}
