pragma solidity >=0.5.16;

contract Election {
    // Model a Candidate
    struct Candidate {
        uint id;
        string name;
        string party;
        uint voteCount;
        string image_url;
    }

    // Store accounts that have voted
    mapping(address => bool) public voters;
    // Store Candidates
    // Fetch Candidate
    mapping(uint => Candidate) public candidates;
    // Store Candidates Count
    uint public candidatesCount;

    // voted event
    event votedEvent (
        uint indexed _candidateId
    );

    constructor () public {
        addCandidate("Rafael Lopez Aliaga", "Renovacion Popular", "https://upload.wikimedia.org/wikipedia/commons/0/0e/Logo_de_Renovaci%C3%B3n_Popular_%28Per%C3%BA%29.png");
        addCandidate("George Forsyth", "Somos Peru", "https://upload.wikimedia.org/wikipedia/commons/c/c9/Logo_Partido_Democr%C3%A1tico_Somos_Per%C3%BA.svg");
        addCandidate("Daniel Urresti", "Podemos Peru", "https://upload.wikimedia.org/wikipedia/commons/thumb/0/07/Logo_Podemos_Per%C3%BA.png/800px-Logo_Podemos_Per%C3%BA.png");
        addCandidate("Elizabeth Leon", "Partido Frente de la Esperanza 2021", "https://upload.wikimedia.org/wikipedia/commons/thumb/5/55/Frente_de_la_Esperanza_2021_%28logo%29.svg/1200px-Frente_de_la_Esperanza_2021_%28logo%29.svg.png");
        addCandidate("Yuri Castro", "Peru Libre", "https://logosenvector.com/logo/img/peru-libre-4356.png");
        addCandidate("Gonzalo Alegria","Juntos por el Peru", "https://upload.wikimedia.org/wikipedia/commons/thumb/6/68/Logo_juntos_por_el_Peru.svg/1200px-Logo_juntos_por_el_Peru.svg.png");
        addCandidate("Omar Chehade","Alianza para el Progreso", "https://upload.wikimedia.org/wikipedia/commons/thumb/3/3c/Alianza_para_el_Progreso_Peru.svg/1200px-Alianza_para_el_Progreso_Peru.svg.png");
        addCandidate("Blanco","Ningun candidato", "");
    }

    function addCandidate (string memory name,string memory party, string memory image_url) private {
        candidatesCount ++;
        candidates[candidatesCount] = Candidate(candidatesCount, name,party, 0, image_url);
    }

    function vote (uint _candidateId) public {
        // require that they haven't voted before
        require(!voters[msg.sender]);

        // require a valid candidate
        require(_candidateId > 0 && _candidateId <= candidatesCount);

        // record that voter has voted
        voters[msg.sender] = true;

        // update candidate vote Count
        candidates[_candidateId].voteCount ++;

        // trigger voted event
        emit votedEvent(_candidateId);
    }
}