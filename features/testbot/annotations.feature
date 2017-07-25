@routing @speed @annotations @turn_penalty
Feature: Annotations

    Background:
        Given the profile "turnbot"
        Given a grid size of 100 meters

    Scenario: Ensure that turn penalties aren't included in speed annotations
        Given the node map
            """
              h i
            j k l m
            """

        And the query options
          | annotations | duration,speed |

        And the ways
            | nodes | highway     |
            | hk    | residential |
            | il    | residential |
            | jk    | residential |
            | lk    | residential |
            | lm    | residential |

        When I route I should get
            # Note: if turn penalties are incorrectly included, some speeds would
            #       be 4, not 6.7
            | from | to | route    | a:speed     |
            | h    | j  | hk,jk,jk | 6.7:6.7     |
            | i    | m  | il,lm,lm | 6.7:6.7     |
            | j    | m  | jk,lm    | 6.7:6.7:6.7 |

