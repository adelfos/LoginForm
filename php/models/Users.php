<?php

use Phalcon\Mvc\Model;
use Phalcon\Mvc\Model\Message;
use Phalcon\Mvc\Model\Validator\Regex;
use Phalcon\Mvc\Model\Validator\Uniqueness;
use Phalcon\Mvc\Model\Validator\InclusionIn;


class Users extends Model
{
    public function validation()
    {
        $this->validate(
            new Uniqueness(
                array(
                    "field"   => "login",
                    "message" => "Логин должен быть уникальным"
                )
            )
        );

        $this->validate(
            new Uniqueness(
                array(
                    "field"   => "email",
                    "message" => "Email должен быть уникальным"
                )
            )
        );

        $this->validate(new Regex(array(
	           "field" => "login",
                "pattern" => "/^[A-z0-9]+$/",
            "message" => "Логин должен содержать только цыфры и латинские буквы"
          )));

        $this->validate(new Regex(array(
            "field" => "login",
            "pattern" => "/^[A-z0-9]+$/",
            "message" => "Логин должен содержать только цыфры и латинские буквы"
        )));

        $this->validate(new Regex(array(
            "field" => "login",
            "pattern" => "/^[A-z0-9]+$/",
            "message" => "Логин должен содержать только цыфры и латинские буквы"
        )));

        $this->validate(new Regex(array(
            "field" => "login",
            "pattern" => "/^[A-z0-9]+$/",
            "message" => "Логин должен содержать только цыфры и латинские буквы"
        )));

        $this->validate(new Regex(array(
            "field" => "login",
            "pattern" => "/^[A-z0-9]+$/",
            "message" => "Логин должен содержать только цыфры и латинские буквы"
        )));




        if ($this->validationHasFailed() == true) {
            return false;
        }
    }
}