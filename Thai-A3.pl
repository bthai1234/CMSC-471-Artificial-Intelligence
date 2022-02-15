%% CMSC471 Fall 2021
%%% Instructor: Fereydoon Vafaei
%% Assignment-3 Logic Programming with Prolog
%% Due Date: Thursday November 11th, 11:59PM

%% TYPE YOUR NAME/ID HERE: Benjamin Thai

%/** Instructions for Completing and Submission of Assignment-3:
% * 1- You should NOT change any existing facts and you should NOT add new facts to the Knowledge Base.
% * 2- Follow the instructions of each rule VERY CAREFULLY!
% * 3- Complete all TEN rules in the TWO parts of this program/file.
% * 4- Make sure to test your rules using the provided queries.
% * 5- You should NOT share any solutions or the query results with other students!
% * 6- Using "File" on the top menu, "Download" the completed .pl file into your computer.
% * 7- If you complete the assignment in multiple sessions, make sure to download/save your work after each session.
% * 8- Name the completed file Lastname-A3.pl
% * 9- Submit ONE file "Lastname-A3.pl" to Blackboard using Assignment-3 link.
%*/

%/** Grading:
% * Assignment-3 has a total of 100 points. The points for each rule is specified.
%
% * NOTE:
% * The rule itself and all the corresponding queries must be completely correct to get the full points for a rule.
% */
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Part-1: Family Tree

% Facts:

female(ann).
female(mary).
female(amy).

male(john).
male(joe).
male(bob).
male(ross).
male(chris).

% parent(A, B) means A is parent of B
parent(ann, mary).
parent(ann, amy).
parent(ann, joe).
parent(john, mary).
parent(john, amy).
parent(john, joe).
parent(bob, ross).
parent(chris, john).
parent(chris, bob).

%/--------------/

% Rules:

% Rule-1 [10 points] mother: Using parent(), and female(),
% write a rule that defines mother(X,Y) such that X is mother of Y.
% Mother is female.
mother(X,Y) :- female(X), parent(X,Y).

% Rule-2 [10 points] father: Using parent(), and male(),
% write a rule that defines father(X,Y) such that X is father of Y.
% Father is male.
father(X,Y) :- male(X), parent(X,Y).

% Rule-3 [10 points] sibling: Using parent()
% write a rule that defines sibling(X, Y) such that X and Y are siblings.
% Nobody can be sibling of herself/himself.
% Notice that (mary, joe) are siblings, (joe, mary) are siblings too.
sibling(X,Y) :- parent(Z,X), parent(Z,Y), not(X=Y).

% Rule-4 [10 points] cousin: Using parent() and sibling(),
% write a rule that defines cousin(X, Y) such that X and Y are cousins.
% Notice that (mary, ross) are cousins, (ross, mary) are cousins too. 
cousin(X,Y) :- sibling(A,B), parent(A,X), parent(B,Y).

% Rule-5 [10 points] spouse: Using parent(),
% write a rule that defines spouse(X, Y) such that X is spouse of Y.
% Nobody can be spouse of herself/himself.
spouse(X,Y) :- parent(X,Z), parent(Y,Z), not(X=Y).

% Rule-6 [10 points] uncle: Using parent(), sibling(), male()
% write a rule that defines uncle(X, Y) such that X is uncle of Y.
% Uncle is male.
uncle(X,Y) :- male(X), sibling(X,Z), parent(Z,Y).

%/--------------/

% Once you completed the rules, run the following queries one at a time,
% The results of the queries are intentionally NOT provided.

% <queries>
% mother(X, Y).
% father(X, Y).
% sibling(X, Y).
% cousin(X, Y).
% spouse(X, Y).
% uncle(X, Y).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Part-2: List Operations

% Rule-7 [10 points] Delete from list. Delete an element X from a list L:
% delete(X, L, Result).
% For example: delete(s1, [s1,s2,s3], Result) % returns Result=[s2,s3]
% Hint: You should write this rule recursively, i.e. 1-line base case and 1-line recursion.
delete(X, [X|Result], Result).
delete(X, [L|Tail], [L|Result]) :- delete(X, Tail, Result).

% Rule-8 [10 points] Compute the product of a list. Multiply all elements in a given list,
% list_product(L, P).
% For example, the product of the list [1, 2, 3] is computed by 1*2*3=6,
% so: list_product([1,2,3], P) % returns P=6
% The product of an empty list is undefined (returns false).
% Hint-1: You should write this rule recursively, i.e. 1-line base case and 1-line recursion.
% Hint-2: You can force the evaluation in arithmetic expressions using "is", e.g.: P is X*Y means P=X*Y
% Hint-3: The base case is NOT an empty list! A query with empty list should return false.
list_product([H], H).
list_product([H|T], P) :- list_product(T, Result), P is H * Result.  

% Rule-9 [10 points] Find the last element of a list L.
% last_element(L, X) % where L is the list and X is the last element
% Hint-1: You should write this rule recursively, i.e. 1-line base case and 1-line recursion.
% Hint-2: The base case is NOT an empty list! A query with empty list should return false.
last_element([X], X).
last_element([_|T], X) :- last_element(T, X). 

% Rule-10 [10 points] Find the length of a given list.
% list_length(L, N) % where L is the list and N is the length of the list
% Note: If there is any built-in method in Prolog for finding the list length, you should NOT use it, you must implement it yourself.
% Hint: You should write this rule recursively, i.e. 1-line base case and 1-line recursion.
list_length([], 0).
list_length([_|T], L) :- list_length(T, Result), L is 1 + Result. 

% <queries>
% Once you completed the rules, run the following queries, and make sure your results are correct.

% delete(s1, [s1,s2,s3], Result). % Result = [s2, s3]
% delete(s2, [s1,s2,s3], Result). % Result = [s1, s3]
% delete(s1, [s1], Result). % Result = []

% list_product([1,2,3], P). % P = 6
% list_product([2,4,6,8,10], P). % P = 3840
% list_product([1,2,3,0], P). % P = 0
% list_product([], P). % false

% last_element([1,2,3], X). % X = 3
% last_element([a,b,c], X). % X = c
% last_element([1], X). % X = 1 
% last_element([], X). % false

% list_length([1,2,3], N). % N = 3
% list_length([1], N). % N = 1
% list_length([], N). % N = 0