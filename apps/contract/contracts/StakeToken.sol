contract StakeToken is ERC20 {
    constructor() ERC20("StakeToken", "SKT") {
        _mint(msg.sender, 1_000_000 * 10 ** decimals());
    }
}
