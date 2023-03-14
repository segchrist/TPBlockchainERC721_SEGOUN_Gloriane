Compile not work


Liste d'erreur


ParserError: Source "@openzeppelin/contracts/utils/introspection/IERC165.sol" not found: Deferred import
--> @openzeppelin/contracts/token/ERC721/IERC721.sol:6:1:
|
6 | import "../../utils/introspection/IERC165.sol";
| ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

ParserError: Source file requires different compiler version (current compiler is 0.8.0+commit.c7dfd78e.Emscripten.clang) - note that nightly builds are considered to be strictly less than the released version
--> @openzeppelin/contracts/utils/Address.sol:4:1:
|
4 | pragma solidity ^0.8.1;
| ^^^^^^^^^^^^^^^^^^^^^^^

ParserError: Source "@openzeppelin/contracts/utils/math/Math.sol" not found: Deferred import
--> @openzeppelin/contracts/utils/Strings.sol:6:1:
|
6 | import "./math/Math.sol";
| ^^^^^^^^^^^^^^^^^^^^^^^^^

ParserError: Source "@openzeppelin/contracts/utils/introspection/IERC165.sol" not found: Deferred import
--> @openzeppelin/contracts/utils/introspection/ERC165.sol:6:1:
|
6 | import "./IERC165.sol";
| ^^^^^^^^^^^^^^^^^^^^^^^
