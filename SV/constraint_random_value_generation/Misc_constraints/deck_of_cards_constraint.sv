//A better approach is creating a ordered deck of cards, then shuffling them.
//suite - 4 (Spade, club, hearts, diamond)
//rank - 13 (Ace,J,K,Q,2,3,4,5,6,7,8,9,10)
//Credits for solution (Dave rich):https://verificationacademy.com/forums/t/constraint-to-generate-deck-of-52-cards/45940/3
package pg;

typedef struct packed{
int suite;
int rank;
}card;

class Foo;
  //array of structures (each element in the deck is an ordered pair of suite & rank which is encapsulated under a packed structure)
  rand card cards[52];
  
  //total 4 suits & 13 ranks
  constraint c1{foreach(cards[i]){
    cards[i].suite inside {[0:3]};
    cards[i].rank inside {[1:13]};
  }
    unique{cards};
  }
    
endclass
endpackage
    
module tb;
import pg::*;

initial begin
  Foo f = new;
  //repeat(10) begin
		assert(f.randomize());
  $display("%p",f.cards); //random ordered collection of 52 suites & rank(ordered pairs)
  //$display("%d",$size(f.cards));
//end
	end


endmodule